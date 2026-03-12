import { Router } from 'express';
import { authMiddleware, AuthRequest } from '../middleware/auth.js';
import { prisma } from '../config/prisma.js';

export const userRouter = Router();
userRouter.use(authMiddleware);

userRouter.get('/me', async (req: AuthRequest, res) => {
  const raw = await prisma.user.findUnique({
    where: { id: req.userId },
    include: { character: true },
  });
  if (!raw) return res.status(404).json({ error: 'User not found' });
  const { passwordHash: _, ...user } = raw;
  res.json(user);
});

userRouter.patch('/me/character', async (req: AuthRequest, res) => {
  const { skinId } = req.body;
  const character = await prisma.character.update({
    where: { userId: req.userId },
    data: { ...(skinId && { skinId }) },
  });
  res.json(character);
});
