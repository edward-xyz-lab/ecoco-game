import dotenv from 'dotenv';
dotenv.config();

export const config = {
  port: parseInt(process.env.PORT || '3000'),
  nodeEnv: process.env.NODE_ENV || 'development',

  jwt: {
    secret: process.env.JWT_SECRET || 'ecoco-game-secret-change-in-prod',
    expiresIn: '7d',
    refreshExpiresIn: '30d',
  },

  redis: {
    // 空字串 = 使用 in-memory fallback
    url: process.env.REDIS_URL || '',
  },

  game: {
    monsterSpawnRadius: 500, // meters
    battleTimeoutMs: 30_000,
    maxMonstersPerStation: 3,
    vipBonusMultiplier: 1.5,
    pointsToCoinsRate: 100, // 100點 = 1幣
  },
} as const;
