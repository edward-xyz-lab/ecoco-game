import { Router } from 'express';
import { body } from 'express-validator';
import { AuthService } from '../services/auth.service.js';
import { validate } from '../middleware/validate.js';

export const authRouter = Router();
const svc = new AuthService();

authRouter.post(
  '/register',
  [
    body('username').isLength({ min: 3, max: 20 }).trim(),
    body('email').isEmail().normalizeEmail(),
    body('password').isLength({ min: 8 }),
  ],
  validate,
  async (req, res) => {
    try {
      const result = await svc.register(req.body.username, req.body.email, req.body.password);
      res.status(201).json(result);
    } catch (e: unknown) {
      res.status(400).json({ error: (e as Error).message });
    }
  },
);

authRouter.post(
  '/login',
  [body('email').isEmail(), body('password').exists()],
  validate,
  async (req, res) => {
    try {
      const result = await svc.login(req.body.email, req.body.password);
      res.json(result);
    } catch (e: unknown) {
      res.status(401).json({ error: (e as Error).message });
    }
  },
);
