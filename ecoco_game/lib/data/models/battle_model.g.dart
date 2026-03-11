// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'battle_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BattleStateImpl _$$BattleStateImplFromJson(Map<String, dynamic> json) =>
    _$BattleStateImpl(
      battleId: json['battleId'] as String,
      monsterId: json['monsterId'] as String,
      status: $enumDecode(_$BattleStatusEnumMap, json['status']),
      playerHp: (json['playerHp'] as num).toInt(),
      playerMaxHp: (json['playerMaxHp'] as num).toInt(),
      monsterHp: (json['monsterHp'] as num).toInt(),
      monsterMaxHp: (json['monsterMaxHp'] as num).toInt(),
      logs: (json['logs'] as List<dynamic>?)
              ?.map((e) => BattleLog.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      turnCount: (json['turnCount'] as num?)?.toInt() ?? 0,
      rewards: (json['rewards'] as List<dynamic>?)
          ?.map((e) => RewardSummary.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BattleStateImplToJson(_$BattleStateImpl instance) =>
    <String, dynamic>{
      'battleId': instance.battleId,
      'monsterId': instance.monsterId,
      'status': _$BattleStatusEnumMap[instance.status]!,
      'playerHp': instance.playerHp,
      'playerMaxHp': instance.playerMaxHp,
      'monsterHp': instance.monsterHp,
      'monsterMaxHp': instance.monsterMaxHp,
      'logs': instance.logs,
      'turnCount': instance.turnCount,
      'rewards': instance.rewards,
    };

const _$BattleStatusEnumMap = {
  BattleStatus.idle: 'idle',
  BattleStatus.scanning: 'scanning',
  BattleStatus.inProgress: 'inProgress',
  BattleStatus.victory: 'victory',
  BattleStatus.defeat: 'defeat',
  BattleStatus.fled: 'fled',
};

_$BattleLogImpl _$$BattleLogImplFromJson(Map<String, dynamic> json) =>
    _$BattleLogImpl(
      actorId: json['actorId'] as String,
      action: json['action'] as String,
      damage: (json['damage'] as num).toInt(),
      remainingHp: (json['remainingHp'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$BattleLogImplToJson(_$BattleLogImpl instance) =>
    <String, dynamic>{
      'actorId': instance.actorId,
      'action': instance.action,
      'damage': instance.damage,
      'remainingHp': instance.remainingHp,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_$RewardSummaryImpl _$$RewardSummaryImplFromJson(Map<String, dynamic> json) =>
    _$RewardSummaryImpl(
      type: json['type'] as String,
      amount: (json['amount'] as num).toInt(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$$RewardSummaryImplToJson(_$RewardSummaryImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'amount': instance.amount,
      'label': instance.label,
    };
