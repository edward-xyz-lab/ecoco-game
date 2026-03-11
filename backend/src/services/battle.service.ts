import { v4 as uuidv4 } from 'uuid';
import { prisma } from '../config/prisma.js';
import { redis } from '../config/redis.js';
import { config } from '../config/index.js';

const BATTLE_TTL = 600; // 10 min

interface BattleSnapshot {
  battleId: string;
  userId: string;
  monsterId: string;
  playerHp: number;
  playerMaxHp: number;
  monsterHp: number;
  monsterMaxHp: number;
  monsterAtk: number;
  monsterDef: number;
  playerAtk: number;
  playerDef: number;
  turnCount: number;
  status: 'IN_PROGRESS' | 'VICTORY' | 'DEFEAT' | 'FLED';
  logs: BattleLog[];
}

interface BattleLog {
  actorId: string;
  action: string;
  damage: number;
  remainingHp: number;
  timestamp: string;
}

export class BattleService {
  async startBattle(userId: string, monsterId: string) {
    const [character, monster] = await Promise.all([
      prisma.character.findUnique({ where: { userId } }),
      prisma.monster.findUnique({ where: { id: monsterId } }),
    ]);

    if (!character) throw new Error('角色不存在');
    if (!monster || !monster.isActive) throw new Error('怪物不存在或已消失');
    if (character.hp <= 0) throw new Error('角色HP耗盡，請先補血');

    const battleId = uuidv4();
    const snapshot: BattleSnapshot = {
      battleId,
      userId,
      monsterId,
      playerHp: character.hp,
      playerMaxHp: character.maxHp,
      monsterHp: monster.maxHp,
      monsterMaxHp: monster.maxHp,
      monsterAtk: monster.attackPower,
      monsterDef: monster.defense,
      playerAtk: character.attackPower,
      playerDef: character.defense,
      turnCount: 0,
      status: 'IN_PROGRESS',
      logs: [],
    };

    await redis.setex(`battle:${battleId}`, BATTLE_TTL, JSON.stringify(snapshot));

    // Track in DB
    await prisma.battle.create({
      data: {
        id: battleId,
        userId,
        monsterId,
        playerHp: character.hp,
        monsterHp: monster.maxHp,
        status: 'IN_PROGRESS',
      },
    });

    return snapshot;
  }

  async attack(battleId: string, userId: string) {
    const snapshot = await this._getSnapshot(battleId, userId);
    if (snapshot.status !== 'IN_PROGRESS') throw new Error('戰鬥已結束');

    // Player attacks
    const playerDmg = this._calcDamage(snapshot.playerAtk, snapshot.monsterDef);
    const newMonsterHp = Math.max(0, snapshot.monsterHp - playerDmg);

    snapshot.logs.push({
      actorId: userId,
      action: 'attack',
      damage: playerDmg,
      remainingHp: newMonsterHp,
      timestamp: new Date().toISOString(),
    });

    if (newMonsterHp <= 0) {
      snapshot.monsterHp = 0;
      snapshot.status = 'VICTORY';
      await this._onVictory(snapshot);
    } else {
      // Monster counter
      const monsterDmg = this._calcDamage(snapshot.monsterAtk, snapshot.playerDef);
      const newPlayerHp = Math.max(0, snapshot.playerHp - monsterDmg);

      snapshot.logs.push({
        actorId: snapshot.monsterId,
        action: 'counter',
        damage: monsterDmg,
        remainingHp: newPlayerHp,
        timestamp: new Date().toISOString(),
      });

      snapshot.monsterHp = newMonsterHp;
      snapshot.playerHp = newPlayerHp;

      if (newPlayerHp <= 0) {
        snapshot.status = 'DEFEAT';
        await this._onDefeat(snapshot);
      }
    }

    snapshot.turnCount += 1;
    await redis.setex(`battle:${battleId}`, BATTLE_TTL, JSON.stringify(snapshot));
    await prisma.battle.update({
      where: { id: battleId },
      data: {
        playerHp: snapshot.playerHp,
        monsterHp: snapshot.monsterHp,
        turnCount: snapshot.turnCount,
        status: snapshot.status,
        finishedAt: snapshot.status !== 'IN_PROGRESS' ? new Date() : undefined,
      },
    });

    return snapshot;
  }

  async flee(battleId: string, userId: string) {
    const snapshot = await this._getSnapshot(battleId, userId);
    snapshot.status = 'FLED';
    await redis.del(`battle:${battleId}`);
    await prisma.battle.update({
      where: { id: battleId },
      data: { status: 'FLED', finishedAt: new Date() },
    });
    return snapshot;
  }

  private async _onVictory(snapshot: BattleSnapshot) {
    const monster = await prisma.monster.findUnique({
      where: { id: snapshot.monsterId },
      include: { rewards: true },
    });
    if (!monster) return;

    const coinsReward = monster.rewards.filter((r) => r.type === 'ECOCO_COINS').reduce((sum, r) => sum + r.amount, 0);
    const pointsReward = monster.rewards.filter((r) => r.type === 'ECOCO_POINTS').reduce((sum, r) => sum + r.amount, 0);

    await Promise.all([
      prisma.user.update({
        where: { id: snapshot.userId },
        data: {
          ecocoCoins: { increment: coinsReward },
          ecocoPoints: { increment: pointsReward },
        },
      }),
      prisma.character.update({
        where: { userId: snapshot.userId },
        data: {
          battlesWon: { increment: 1 },
          monstersKilled: { increment: 1 },
        },
      }),
      // Deactivate monster so nobody else can fight it
      prisma.monster.update({
        where: { id: snapshot.monsterId },
        data: { isActive: false },
      }),
    ]);
  }

  private async _onDefeat(snapshot: BattleSnapshot) {
    await prisma.character.update({
      where: { userId: snapshot.userId },
      data: { hp: 0 },
    });
  }

  private async _getSnapshot(battleId: string, userId: string): Promise<BattleSnapshot> {
    const raw = await redis.get(`battle:${battleId}`);
    if (!raw) throw new Error('戰鬥不存在或已逾時');
    const snapshot: BattleSnapshot = JSON.parse(raw);
    if (snapshot.userId !== userId) throw new Error('無權限');
    return snapshot;
  }

  private _calcDamage(atk: number, def: number): number {
    const base = Math.max(1, atk - def * 0.5);
    const variance = 0.85 + Math.random() * 0.3; // ±15%
    const crit = Math.random() < 0.1 ? 2 : 1;
    return Math.floor(base * variance * crit);
  }
}
