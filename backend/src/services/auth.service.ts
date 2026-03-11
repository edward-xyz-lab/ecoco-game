import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { prisma } from '../config/prisma.js';
import { config } from '../config/index.js';

export class AuthService {
  async register(username: string, email: string, password: string) {
    const existing = await prisma.user.findFirst({
      where: { OR: [{ email }, { username }] },
    });
    if (existing) throw new Error('Email 或用戶名已存在');

    const passwordHash = await bcrypt.hash(password, 12);

    const user = await prisma.user.create({
      data: {
        username,
        email,
        passwordHash,
        character: {
          create: {},
        },
      },
      include: { character: true },
    });

    return this._buildTokens(user);
  }

  async login(email: string, password: string) {
    const user = await prisma.user.findUnique({
      where: { email },
      include: { character: true },
    });
    if (!user) throw new Error('帳號或密碼錯誤');

    const valid = await bcrypt.compare(password, user.passwordHash);
    if (!valid) throw new Error('帳號或密碼錯誤');

    return this._buildTokens(user);
  }

  private _buildTokens(user: { id: string; username: string; email: string; ecocoPoints: number; ecocoCoins: number; isVip: boolean; character: unknown }) {
    const accessToken = jwt.sign({ sub: user.id }, config.jwt.secret, {
      expiresIn: config.jwt.expiresIn,
    });
    const refreshToken = jwt.sign({ sub: user.id, type: 'refresh' }, config.jwt.secret, {
      expiresIn: config.jwt.refreshExpiresIn,
    });

    return {
      accessToken,
      refreshToken,
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        ecocoPoints: user.ecocoPoints,
        ecocoCoins: user.ecocoCoins,
        isVip: user.isVip,
        character: user.character,
      },
    };
  }
}
