import Redis from 'ioredis';
import { config } from './index.js';

export const redis = new Redis(config.redis.url, {
  lazyConnect: true,
  maxRetriesPerRequest: 3,
});

redis.on('error', (err) => console.error('[Redis]', err.message));
redis.on('connect', () => console.log('[Redis] Connected'));
