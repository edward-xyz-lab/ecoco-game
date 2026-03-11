import { Router } from 'express';
import { body } from 'express-validator';
import { authMiddleware, AuthRequest } from '../middleware/auth.js';
import { validate } from '../middleware/validate.js';
import { BattleService } from '../services/battle.service.js';

export const battleRouter = Router();
const svc = new BattleService();

battleRouter.use(authMiddleware);

battleRouter.post(
  '/start',
  [body('monsterId').isUUID()],
  validate,
  async (req: AuthRequest, res) => {
    try {
      const state = await svc.startBattle(req.userId!, req.body.monsterId);
      res.status(201).json(state);
    } catch (e: unknown) {
      res.status(400).json({ error: (e as Error).message });
    }
  },
);

battleRouter.post('/:id/action', async (req: AuthRequest, res) => {
  const { action } = req.body;
  try {
    let state;
    if (action === 'attack') {
      state = await svc.attack(req.params.id, req.userId!);
    } else if (action === 'flee') {
      state = await svc.flee(req.params.id, req.userId!);
    } else {
      return res.status(400).json({ error: 'Unknown action' });
    }
    res.json(state);
  } catch (e: unknown) {
    res.status(400).json({ error: (e as Error).message });
  }
});

battleRouter.get('/:id', async (req: AuthRequest, res) => {
  const { redis } = await import('../config/redis.js');
  const raw = await redis.get(`battle:${req.params.id}`);
  if (!raw) return res.status(404).json({ error: 'Battle not found' });
  const state = JSON.parse(raw);
  if (state.userId !== req.userId) return res.status(403).json({ error: 'Forbidden' });
  res.json(state);
});
