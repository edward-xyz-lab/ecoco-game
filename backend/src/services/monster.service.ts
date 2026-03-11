import { getDistance } from 'geolib';
import { prisma } from '../config/prisma.js';
import { redis } from '../config/redis.js';
import { config } from '../config/index.js';

const MONSTER_CACHE_TTL = 60; // seconds

export class MonsterService {
  async getNearbyMonsters(lat: number, lng: number, radius = config.game.monsterSpawnRadius) {
    const cacheKey = `monsters:nearby:${lat.toFixed(3)}:${lng.toFixed(3)}`;
    const cached = await redis.get(cacheKey);
    if (cached) return JSON.parse(cached);

    const monsters = await prisma.monster.findMany({
      where: { isActive: true, expiresAt: { gt: new Date() } },
      include: { rewards: true },
    });

    const nearby = monsters.filter((m) => {
      const dist = getDistance(
        { latitude: lat, longitude: lng },
        { latitude: m.latitude, longitude: m.longitude },
      );
      return dist <= radius;
    });

    await redis.setex(cacheKey, MONSTER_CACHE_TTL, JSON.stringify(nearby));
    return nearby;
  }

  async spawnMonsterAtStation(stationId: string) {
    const station = await prisma.station.findUnique({ where: { id: stationId } });
    if (!station) throw new Error('站點不存在');

    const rarities = ['COMMON', 'COMMON', 'COMMON', 'UNCOMMON', 'UNCOMMON', 'RARE', 'EPIC', 'LEGENDARY'] as const;
    const rarity = rarities[Math.floor(Math.random() * rarities.length)];

    const templates = _monsterTemplates[rarity];
    const template = templates[Math.floor(Math.random() * templates.length)];

    const expiresAt = new Date(Date.now() + 4 * 60 * 60 * 1000); // 4 hours

    return prisma.monster.create({
      data: {
        ...template,
        rarity,
        latitude: station.latitude + (Math.random() - 0.5) * 0.002,
        longitude: station.longitude + (Math.random() - 0.5) * 0.002,
        stationId,
        expiresAt,
        rewards: {
          create: _rewardsForRarity(rarity),
        },
      },
      include: { rewards: true },
    });
  }
}

const _monsterTemplates = {
  COMMON: [
    { name: '電池怪', type: 'BATTERY' as const, maxHp: 80, attackPower: 10, defense: 5 },
    { name: '小塑膠鬼', type: 'PLASTIC' as const, maxHp: 60, attackPower: 8, defense: 3 },
  ],
  UNCOMMON: [
    { name: '廢電池精', type: 'BATTERY' as const, maxHp: 150, attackPower: 18, defense: 10 },
    { name: '汙染雲', type: 'POLLUTION' as const, maxHp: 120, attackPower: 22, defense: 7 },
  ],
  RARE: [
    { name: '塑膠魔', type: 'PLASTIC' as const, maxHp: 280, attackPower: 35, defense: 20 },
    { name: '毒氣怪', type: 'POLLUTION' as const, maxHp: 250, attackPower: 40, defense: 15 },
  ],
  EPIC: [
    { name: '企業惡龍', type: 'CORPORATE' as const, maxHp: 500, attackPower: 60, defense: 35 },
  ],
  LEGENDARY: [
    { name: '末日汙染王', type: 'POLLUTION' as const, maxHp: 1000, attackPower: 100, defense: 60 },
  ],
};

function _rewardsForRarity(rarity: string) {
  const base = { COMMON: 10, UNCOMMON: 30, RARE: 80, EPIC: 200, LEGENDARY: 500 };
  const coins = base[rarity as keyof typeof base] ?? 10;

  return [
    { type: 'ECOCO_COINS' as const, amount: coins, description: `ECOCO幣 x${coins}` },
    { type: 'ECOCO_POINTS' as const, amount: coins * 5, description: `點數 x${coins * 5}` },
  ];
}
