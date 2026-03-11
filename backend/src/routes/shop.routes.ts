import { Router } from 'express';
import { body } from 'express-validator';
import { authMiddleware, AuthRequest } from '../middleware/auth.js';
import { validate } from '../middleware/validate.js';
import { prisma } from '../config/prisma.js';

export const shopRouter = Router();
shopRouter.use(authMiddleware);

shopRouter.get('/items', async (_, res) => {
  const items = await prisma.shopItem.findMany({ where: { isActive: true } });
  res.json(items);
});

shopRouter.post(
  '/purchase',
  [body('itemId').isUUID()],
  validate,
  async (req: AuthRequest, res) => {
    const item = await prisma.shopItem.findUnique({ where: { id: req.body.itemId } });
    if (!item) return res.status(404).json({ error: 'Item not found' });

    const user = await prisma.user.findUnique({ where: { id: req.userId } });
    if (!user || user.ecocoCoins < item.coinPrice) {
      return res.status(400).json({ error: 'ECOCO幣不足' });
    }

    const [updatedUser] = await prisma.$transaction([
      prisma.user.update({
        where: { id: req.userId },
        data: { ecocoCoins: { decrement: item.coinPrice } },
      }),
      // 直接 create，商店購耗材類允許疊加數量
      prisma.inventoryItem.create({
        data: { userId: req.userId!, itemId: item.id, quantity: 1 },
      }),
      prisma.purchase.create({
        data: { userId: req.userId!, itemId: item.id, coinsPaid: item.coinPrice },
      }),
    ]);

    res.json({ success: true, itemId: item.id, remainingCoins: updatedUser.ecocoCoins });
  },
);
