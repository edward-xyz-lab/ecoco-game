import { Server, Socket } from 'socket.io';
import jwt from 'jsonwebtoken';
import { config } from '../config/index.js';
import { BattleService } from '../services/battle.service.js';

const battleSvc = new BattleService();

interface SocketWithUser extends Socket {
  userId?: string;
}

export function setupBattleSocket(io: Server) {
  const battleNs = io.of('/battle');

  // Auth middleware
  battleNs.use((socket: SocketWithUser, next) => {
    const token = socket.handshake.auth.token as string;
    try {
      const payload = jwt.verify(token, config.jwt.secret) as { sub: string };
      socket.userId = payload.sub;
      next();
    } catch {
      next(new Error('Authentication error'));
    }
  });

  battleNs.on('connection', (socket: SocketWithUser) => {
    console.log(`[Battle Socket] User ${socket.userId} connected`);

    socket.on('join_battle', (battleId: string) => {
      socket.join(`battle:${battleId}`);
    });

    socket.on('attack', async ({ battleId }: { battleId: string }) => {
      try {
        const state = await battleSvc.attack(battleId, socket.userId!);
        battleNs.to(`battle:${battleId}`).emit('battle_update', state);

        if (state.status !== 'IN_PROGRESS') {
          battleNs.to(`battle:${battleId}`).emit('battle_end', state);
        }
      } catch (e: unknown) {
        socket.emit('error', { message: (e as Error).message });
      }
    });

    socket.on('flee', async ({ battleId }: { battleId: string }) => {
      try {
        const state = await battleSvc.flee(battleId, socket.userId!);
        battleNs.to(`battle:${battleId}`).emit('battle_end', state);
      } catch (e: unknown) {
        socket.emit('error', { message: (e as Error).message });
      }
    });

    socket.on('disconnect', () => {
      console.log(`[Battle Socket] User ${socket.userId} disconnected`);
    });
  });
}
