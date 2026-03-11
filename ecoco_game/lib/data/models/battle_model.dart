import 'package:freezed_annotation/freezed_annotation.dart';

part 'battle_model.freezed.dart';
part 'battle_model.g.dart';

enum BattleStatus { idle, scanning, inProgress, victory, defeat, fled }

enum BattleActionType { attack, useItem, flee }

@freezed
class BattleState with _$BattleState {
  const factory BattleState({
    required String battleId,
    required String monsterId,
    required BattleStatus status,
    required int playerHp,
    required int playerMaxHp,
    required int monsterHp,
    required int monsterMaxHp,
    @Default([]) List<BattleLog> logs,
    @Default(0) int turnCount,
    List<RewardSummary>? rewards,
  }) = _BattleState;

  factory BattleState.fromJson(Map<String, dynamic> json) =>
      _$BattleStateFromJson(json);
}

@freezed
class BattleLog with _$BattleLog {
  const factory BattleLog({
    required String actorId,
    required String action,
    required int damage,
    required int remainingHp,
    required DateTime timestamp,
  }) = _BattleLog;

  factory BattleLog.fromJson(Map<String, dynamic> json) =>
      _$BattleLogFromJson(json);
}

@freezed
class RewardSummary with _$RewardSummary {
  const factory RewardSummary({
    required String type,
    required int amount,
    String? label,
  }) = _RewardSummary;

  factory RewardSummary.fromJson(Map<String, dynamic> json) =>
      _$RewardSummaryFromJson(json);
}
