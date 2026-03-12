import Redis from 'ioredis';
import { config } from './index.js';

// In-memory fallback when Redis is not configured
const memStore = new Map<string, { value: string; expiresAt: number }>();

function memGet(key: string) {
  const entry = memStore.get(key);
  if (!entry) return null;
  if (Date.now() > entry.expiresAt) { memStore.delete(key); return null; }
  return entry.value;
}
function memSet(key: string, ttl: number, value: string) {
  memStore.set(key, { value, expiresAt: Date.now() + ttl * 1000 });
}
function memDel(key: string) { memStore.delete(key); }

// Redis adapter — real or in-memory
export const redis = config.redis.url
  ? (() => {
      const client = new Redis(config.redis.url, {
        lazyConnect: true,
        maxRetriesPerRequest: 3,
        enableOfflineQueue: false,
      });
      client.on('error', (err) => console.error('[Redis]', err.message));
      client.on('connect', () => console.log('[Redis] Connected'));
      return client;
    })()
  : {
      // Minimal in-memory shim
      connect: async () => { console.log('[Redis] Using in-memory store'); },
      get: async (key: string) => memGet(key),
      setex: async (key: string, ttl: number, value: string) => { memSet(key, ttl, value); return 'OK'; },
      del: async (key: string) => { memDel(key); return 1; },
      quit: async () => {},
      on: (_: string, __: unknown) => {},
    } as unknown as Redis;
