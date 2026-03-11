import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/user_model.dart';
import '../../data/models/monster_model.dart';
import '../../data/models/battle_model.dart';

part 'game_provider.g.dart';

// ── Auth ──────────────────────────────────────────────────────────────────────

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<UserModel?> build() => const AsyncValue.data(null);

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: inject GameApi via DI
      throw UnimplementedError();
    });
  }

  void logout() => state = const AsyncValue.data(null);
}

// ── Currency ──────────────────────────────────────────────────────────────────

@riverpod
class CurrencyNotifier extends _$CurrencyNotifier {
  @override
  CurrencyState build() => const CurrencyState(points: 0, coins: 0);

  void update({int? points, int? coins}) {
    state = state.copyWith(
      points: points ?? state.points,
      coins: coins ?? state.coins,
    );
  }
}

class CurrencyState {
  final int points;
  final int coins;

  const CurrencyState({required this.points, required this.coins});

  CurrencyState copyWith({int? points, int? coins}) => CurrencyState(
        points: points ?? this.points,
        coins: coins ?? this.coins,
      );
}

// ── Map / Monsters ─────────────────────────────────────────────────────────────

@riverpod
class NearbyMonstersNotifier extends _$NearbyMonstersNotifier {
  @override
  AsyncValue<List<MonsterModel>> build() => const AsyncValue.data([]);

  Future<void> refresh(double lat, double lng) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: call GameApi.getNearbyMonsters
      return _mockMonsters(lat, lng);
    });
  }

  List<MonsterModel> _mockMonsters(double lat, double lng) => [
        MonsterModel(
          id: 'mock-1',
          name: '電池怪',
          rarity: MonsterRarity.common,
          type: MonsterType.battery,
          hp: 80,
          maxHp: 80,
          attackPower: 12,
          defense: 5,
          latitude: lat + 0.001,
          longitude: lng + 0.001,
          stationId: 'station-001',
          rewards: [
            const RewardModel(
              type: RewardType.ecocoCoins,
              amount: 10,
              description: 'ECOCO幣 x10',
            ),
          ],
        ),
        MonsterModel(
          id: 'mock-2',
          name: '塑膠魔王',
          rarity: MonsterRarity.rare,
          type: MonsterType.plastic,
          hp: 200,
          maxHp: 200,
          attackPower: 25,
          defense: 15,
          latitude: lat - 0.002,
          longitude: lng + 0.002,
          stationId: 'station-002',
          rewards: [
            const RewardModel(
              type: RewardType.ecocoCoins,
              amount: 50,
              description: 'ECOCO幣 x50',
            ),
            const RewardModel(
              type: RewardType.coupon,
              amount: 1,
              description: '折扣券',
            ),
          ],
        ),
      ];
}

// ── Battle ────────────────────────────────────────────────────────────────────

@riverpod
class BattleNotifier extends _$BattleNotifier {
  @override
  BattleState? build() => null;

  Future<void> startBattle(String monsterId, String stationId) async {
    // TODO: call GameApi.startBattle, then connect socket
    state = BattleState(
      battleId: 'battle-${DateTime.now().millisecondsSinceEpoch}',
      monsterId: monsterId,
      status: BattleStatus.inProgress,
      playerHp: 100,
      playerMaxHp: 100,
      monsterHp: 80,
      monsterMaxHp: 80,
      logs: [],
      turnCount: 0,
    );
  }

  Future<void> attack() async {
    final current = state;
    if (current == null || current.status != BattleStatus.inProgress) return;

    final playerDmg = 15 + (DateTime.now().millisecond % 10);
    final monsterDmg = 8 + (DateTime.now().second % 8);

    final newMonsterHp = (current.monsterHp - playerDmg).clamp(0, current.monsterMaxHp);
    final newPlayerHp = (current.playerHp - monsterDmg).clamp(0, current.playerMaxHp);

    final won = newMonsterHp <= 0;
    final lost = newPlayerHp <= 0;

    state = current.copyWith(
      monsterHp: newMonsterHp,
      playerHp: newPlayerHp,
      turnCount: current.turnCount + 1,
      status: won
          ? BattleStatus.victory
          : lost
              ? BattleStatus.defeat
              : BattleStatus.inProgress,
      logs: [
        ...current.logs,
        BattleLog(
          actorId: 'player',
          action: 'attack',
          damage: playerDmg,
          remainingHp: newMonsterHp,
          timestamp: DateTime.now(),
        ),
        BattleLog(
          actorId: current.monsterId,
          action: 'counter',
          damage: monsterDmg,
          remainingHp: newPlayerHp,
          timestamp: DateTime.now(),
        ),
      ],
      rewards: won
          ? [
              const RewardSummary(type: 'coins', amount: 20, label: 'ECOCO幣'),
              const RewardSummary(type: 'points', amount: 50, label: '點數'),
            ]
          : null,
    );
  }

  void flee() {
    state = state?.copyWith(status: BattleStatus.fled);
  }

  void reset() => state = null;
}
