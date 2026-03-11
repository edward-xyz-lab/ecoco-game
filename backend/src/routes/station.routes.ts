import { Router } from 'express';
import { authMiddleware, AuthRequest } from '../middleware/auth.js';
import { prisma } from '../config/prisma.js';
import { MonsterService } from '../services/monster.service.js';

export const stationRouter = Router();
const monsterSvc = new MonsterService();

stationRouter.use(authMiddleware);

// QR 掃描站點 → 觸發打怪 or 補充行為
stationRouter.post('/:stationId/scan', async (req: AuthRequest, res) => {
  const { stationId } = req.params;
  const { action } = req.body; // 'battle' | 'recharge_energy' | 'recharge_hp'

  const station = await prisma.station.findUnique({ where: { id: stationId } });
  if (!station || !station.isActive) {
    return res.status(404).json({ error: '站點不存在或已停用' });
  }

  if (action === 'battle') {
    // 嘗試找該站點的活躍怪物，若無則生成
    let monster = await prisma.monster.findFirst({
      where: { stationId, isActive: true },
    });

    if (!monster) {
      monster = await monsterSvc.spawnMonsterAtStation(stationId);
    }

    return res.json({
      valid: true,
      stationId,
      monsterId: monster.id,
      message: `發現 ${monster.name}！準備戰鬥！`,
    });
  }

  if (action === 'recharge_energy') {
    // 到站點補電量（免費，現實中需投電池）
    await prisma.character.update({
      where: { userId: req.userId },
      data: { energy: 100 },
    });
    return res.json({
      valid: true,
      stationId,
      message: '電量已補滿！',
    });
  }

  if (action === 'recharge_hp') {
    // 到補充站補血（免費）
    const char = await prisma.character.findUnique({ where: { userId: req.userId } });
    await prisma.character.update({
      where: { userId: req.userId },
      data: { hp: char?.maxHp ?? 100 },
    });
    return res.json({
      valid: true,
      stationId,
      message: 'HP已補滿！',
    });
  }

  res.status(400).json({ error: 'Unknown action' });
});
