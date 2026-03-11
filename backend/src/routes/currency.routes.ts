import { Router } from 'express';
import { body } from 'express-validator';
import { authMiddleware, AuthRequest } from '../middleware/auth.js';
import { validate } from '../middleware/validate.js';
import { prisma } from '../config/prisma.js';
import { config } from '../config/index.js';

export const currencyRouter = Router();
currencyRouter.use(authMiddleware);

// 點數 → 幣
currencyRouter.post(
  '/convert-points',
  [body('points').isInt({ min: config.game.pointsToCoinsRate })],
  validate,
  async (req: AuthRequest, res) => {
    const points: number = req.body.points;
    const coins = Math.floor(points / config.game.pointsToCoinsRate);

    const user = await prisma.user.findUnique({ where: { id: req.userId } });
    if (!user || user.ecocoPoints < points) {
      return res.status(400).json({ error: '點數不足' });
    }

    const updated = await prisma.user.update({
      where: { id: req.userId },
      data: {
        ecocoPoints: { decrement: points },
        ecocoCoins: { increment: coins },
      },
    });

    res.json({ ecocoPoints: updated.ecocoPoints, ecocoCoins: updated.ecocoCoins });
  },
);

// 用幣補電量
currencyRouter.post('/recharge-energy', async (req: AuthRequest, res) => {
  const COST = 5;
  const user = await prisma.user.findUnique({ where: { id: req.userId } });
  if (!user || user.ecocoCoins < COST) {
    return res.status(400).json({ error: 'ECOCO幣不足，需要5幣' });
  }

  const [, character] = await prisma.$transaction([
    prisma.user.update({
      where: { id: req.userId },
      data: { ecocoCoins: { decrement: COST } },
    }),
    prisma.character.update({
      where: { userId: req.userId },
      data: { energy: 100 },
    }),
  ]);

  res.json(character);
});

// 用幣補血
currencyRouter.post('/recharge-hp', async (req: AuthRequest, res) => {
  const COST = 3;
  const user = await prisma.user.findUnique({ where: { id: req.userId } });
  if (!user || user.ecocoCoins < COST) {
    return res.status(400).json({ error: 'ECOCO幣不足，需要3幣' });
  }

  const char = await prisma.character.findUnique({ where: { userId: req.userId } });
  const [, character] = await prisma.$transaction([
    prisma.user.update({
      where: { id: req.userId },
      data: { ecocoCoins: { decrement: COST } },
    }),
    prisma.character.update({
      where: { userId: req.userId },
      data: { hp: char?.maxHp ?? 100 },
    }),
  ]);

  res.json(character);
});
