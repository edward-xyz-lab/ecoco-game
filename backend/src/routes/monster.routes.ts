import { Router } from 'express';
import { query } from 'express-validator';
import { authMiddleware } from '../middleware/auth.js';
import { validate } from '../middleware/validate.js';
import { MonsterService } from '../services/monster.service.js';

export const monsterRouter = Router();
const svc = new MonsterService();

monsterRouter.use(authMiddleware);

monsterRouter.get(
  '/nearby',
  [
    query('lat').isFloat({ min: -90, max: 90 }),
    query('lng').isFloat({ min: -180, max: 180 }),
    query('radius').optional().isFloat({ min: 100, max: 2000 }),
  ],
  validate,
  async (req, res) => {
    const lat = parseFloat(req.query.lat as string);
    const lng = parseFloat(req.query.lng as string);
    const radius = req.query.radius ? parseFloat(req.query.radius as string) : undefined;

    const monsters = await svc.getNearbyMonsters(lat, lng, radius);
    res.json(monsters);
  },
);

monsterRouter.get('/:id', async (req, res) => {
  const { prisma } = await import('../config/prisma.js');
  const monster = await prisma.monster.findUnique({
    where: { id: req.params.id },
    include: { rewards: true },
  });
  if (!monster) return res.status(404).json({ error: 'Monster not found' });
  res.json(monster);
});
