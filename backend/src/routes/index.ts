import { Router } from 'express';
import { authRouter } from './auth.routes.js';
import { userRouter } from './user.routes.js';
import { monsterRouter } from './monster.routes.js';
import { battleRouter } from './battle.routes.js';
import { currencyRouter } from './currency.routes.js';
import { shopRouter } from './shop.routes.js';
import { stationRouter } from './station.routes.js';
import { adminRouter } from './admin.routes.js';

const router = Router();

router.use('/auth', authRouter);
router.use('/users', userRouter);
router.use('/monsters', monsterRouter);
router.use('/battles', battleRouter);
router.use('/currency', currencyRouter);
router.use('/shop', shopRouter);
router.use('/stations', stationRouter);
router.use('/admin', adminRouter);

router.get('/health', (_, res) => res.json({ status: 'ok', ts: new Date().toISOString() }));

export default router;
