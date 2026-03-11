import { Router } from 'express';
import { prisma } from '../config/prisma.js';

export const adminRouter = Router();

// Stats overview
adminRouter.get('/stats', async (_req, res) => {
  try {
    const [users, monsters, battles, stations, shopItems] = await Promise.all([
      prisma.user.count(),
      prisma.monster.count(),
      prisma.battle.count(),
      prisma.station.count(),
      prisma.shopItem.count(),
    ]);
    const battleStats = await prisma.battle.groupBy({
      by: ['status'],
      _count: true,
    });
    const vipCount = await prisma.user.count({ where: { isVip: true } });
    const activeMonsters = await prisma.monster.count({ where: { isActive: true } });
    res.json({ users, monsters, activeMonsters, battles, stations, shopItems, vipCount, battleStats });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

// Users
adminRouter.get('/users', async (req, res) => {
  try {
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 20;
    const [data, total] = await Promise.all([
      prisma.user.findMany({
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: { character: true },
      }),
      prisma.user.count(),
    ]);
    res.json({ data, total, page, limit });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.patch('/users/:id', async (req, res) => {
  try {
    const { ecocoPoints, ecocoCoins, isVip } = req.body;
    const user = await prisma.user.update({
      where: { id: req.params.id },
      data: { ecocoPoints, ecocoCoins, isVip },
    });
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.delete('/users/:id', async (req, res) => {
  try {
    await prisma.user.delete({ where: { id: req.params.id } });
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

// Monsters
adminRouter.get('/monsters', async (req, res) => {
  try {
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 20;
    const [data, total] = await Promise.all([
      prisma.monster.findMany({
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: { rewards: true },
      }),
      prisma.monster.count(),
    ]);
    res.json({ data, total, page, limit });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.post('/monsters', async (req, res) => {
  try {
    const monster = await prisma.monster.create({ data: req.body });
    res.status(201).json(monster);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.patch('/monsters/:id', async (req, res) => {
  try {
    const monster = await prisma.monster.update({
      where: { id: req.params.id },
      data: req.body,
    });
    res.json(monster);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.delete('/monsters/:id', async (req, res) => {
  try {
    await prisma.monster.delete({ where: { id: req.params.id } });
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

// Shop Items
adminRouter.get('/shop', async (_req, res) => {
  try {
    const data = await prisma.shopItem.findMany({ orderBy: { createdAt: 'desc' } });
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.post('/shop', async (req, res) => {
  try {
    const item = await prisma.shopItem.create({ data: req.body });
    res.status(201).json(item);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.patch('/shop/:id', async (req, res) => {
  try {
    const item = await prisma.shopItem.update({
      where: { id: req.params.id },
      data: req.body,
    });
    res.json(item);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.delete('/shop/:id', async (req, res) => {
  try {
    await prisma.shopItem.delete({ where: { id: req.params.id } });
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

// Stations
adminRouter.get('/stations', async (_req, res) => {
  try {
    const data = await prisma.station.findMany();
    res.json(data);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.post('/stations', async (req, res) => {
  try {
    const station = await prisma.station.create({ data: req.body });
    res.status(201).json(station);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.patch('/stations/:id', async (req, res) => {
  try {
    const station = await prisma.station.update({
      where: { id: req.params.id },
      data: req.body,
    });
    res.json(station);
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

adminRouter.delete('/stations/:id', async (req, res) => {
  try {
    await prisma.station.delete({ where: { id: req.params.id } });
    res.json({ ok: true });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});

// Battles
adminRouter.get('/battles', async (req, res) => {
  try {
    const page = Number(req.query.page) || 1;
    const limit = Number(req.query.limit) || 20;
    const [data, total] = await Promise.all([
      prisma.battle.findMany({
        skip: (page - 1) * limit,
        take: limit,
        orderBy: { createdAt: 'desc' },
        include: {
          user: { select: { username: true, email: true } },
          monster: { select: { name: true, rarity: true } },
        },
      }),
      prisma.battle.count(),
    ]);
    res.json({ data, total, page, limit });
  } catch (e) {
    res.status(500).json({ error: (e as Error).message });
  }
});
