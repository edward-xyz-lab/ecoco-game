// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'battle_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BattleState _$BattleStateFromJson(Map<String, dynamic> json) {
  return _BattleState.fromJson(json);
}

/// @nodoc
mixin _$BattleState {
  String get battleId => throw _privateConstructorUsedError;
  String get monsterId => throw _privateConstructorUsedError;
  BattleStatus get status => throw _privateConstructorUsedError;
  int get playerHp => throw _privateConstructorUsedError;
  int get playerMaxHp => throw _privateConstructorUsedError;
  int get monsterHp => throw _privateConstructorUsedError;
  int get monsterMaxHp => throw _privateConstructorUsedError;
  List<BattleLog> get logs => throw _privateConstructorUsedError;
  int get turnCount => throw _privateConstructorUsedError;
  List<RewardSummary>? get rewards => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleStateCopyWith<BattleState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleStateCopyWith<$Res> {
  factory $BattleStateCopyWith(
          BattleState value, $Res Function(BattleState) then) =
      _$BattleStateCopyWithImpl<$Res, BattleState>;
  @useResult
  $Res call(
      {String battleId,
      String monsterId,
      BattleStatus status,
      int playerHp,
      int playerMaxHp,
      int monsterHp,
      int monsterMaxHp,
      List<BattleLog> logs,
      int turnCount,
      List<RewardSummary>? rewards});
}

/// @nodoc
class _$BattleStateCopyWithImpl<$Res, $Val extends BattleState>
    implements $BattleStateCopyWith<$Res> {
  _$BattleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? monsterId = null,
    Object? status = null,
    Object? playerHp = null,
    Object? playerMaxHp = null,
    Object? monsterHp = null,
    Object? monsterMaxHp = null,
    Object? logs = null,
    Object? turnCount = null,
    Object? rewards = freezed,
  }) {
    return _then(_value.copyWith(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      monsterId: null == monsterId
          ? _value.monsterId
          : monsterId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BattleStatus,
      playerHp: null == playerHp
          ? _value.playerHp
          : playerHp // ignore: cast_nullable_to_non_nullable
              as int,
      playerMaxHp: null == playerMaxHp
          ? _value.playerMaxHp
          : playerMaxHp // ignore: cast_nullable_to_non_nullable
              as int,
      monsterHp: null == monsterHp
          ? _value.monsterHp
          : monsterHp // ignore: cast_nullable_to_non_nullable
              as int,
      monsterMaxHp: null == monsterMaxHp
          ? _value.monsterMaxHp
          : monsterMaxHp // ignore: cast_nullable_to_non_nullable
              as int,
      logs: null == logs
          ? _value.logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<BattleLog>,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
      rewards: freezed == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardSummary>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleStateImplCopyWith<$Res>
    implements $BattleStateCopyWith<$Res> {
  factory _$$BattleStateImplCopyWith(
          _$BattleStateImpl value, $Res Function(_$BattleStateImpl) then) =
      __$$BattleStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String battleId,
      String monsterId,
      BattleStatus status,
      int playerHp,
      int playerMaxHp,
      int monsterHp,
      int monsterMaxHp,
      List<BattleLog> logs,
      int turnCount,
      List<RewardSummary>? rewards});
}

/// @nodoc
class __$$BattleStateImplCopyWithImpl<$Res>
    extends _$BattleStateCopyWithImpl<$Res, _$BattleStateImpl>
    implements _$$BattleStateImplCopyWith<$Res> {
  __$$BattleStateImplCopyWithImpl(
      _$BattleStateImpl _value, $Res Function(_$BattleStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? battleId = null,
    Object? monsterId = null,
    Object? status = null,
    Object? playerHp = null,
    Object? playerMaxHp = null,
    Object? monsterHp = null,
    Object? monsterMaxHp = null,
    Object? logs = null,
    Object? turnCount = null,
    Object? rewards = freezed,
  }) {
    return _then(_$BattleStateImpl(
      battleId: null == battleId
          ? _value.battleId
          : battleId // ignore: cast_nullable_to_non_nullable
              as String,
      monsterId: null == monsterId
          ? _value.monsterId
          : monsterId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BattleStatus,
      playerHp: null == playerHp
          ? _value.playerHp
          : playerHp // ignore: cast_nullable_to_non_nullable
              as int,
      playerMaxHp: null == playerMaxHp
          ? _value.playerMaxHp
          : playerMaxHp // ignore: cast_nullable_to_non_nullable
              as int,
      monsterHp: null == monsterHp
          ? _value.monsterHp
          : monsterHp // ignore: cast_nullable_to_non_nullable
              as int,
      monsterMaxHp: null == monsterMaxHp
          ? _value.monsterMaxHp
          : monsterMaxHp // ignore: cast_nullable_to_non_nullable
              as int,
      logs: null == logs
          ? _value._logs
          : logs // ignore: cast_nullable_to_non_nullable
              as List<BattleLog>,
      turnCount: null == turnCount
          ? _value.turnCount
          : turnCount // ignore: cast_nullable_to_non_nullable
              as int,
      rewards: freezed == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardSummary>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleStateImpl implements _BattleState {
  const _$BattleStateImpl(
      {required this.battleId,
      required this.monsterId,
      required this.status,
      required this.playerHp,
      required this.playerMaxHp,
      required this.monsterHp,
      required this.monsterMaxHp,
      final List<BattleLog> logs = const [],
      this.turnCount = 0,
      final List<RewardSummary>? rewards})
      : _logs = logs,
        _rewards = rewards;

  factory _$BattleStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleStateImplFromJson(json);

  @override
  final String battleId;
  @override
  final String monsterId;
  @override
  final BattleStatus status;
  @override
  final int playerHp;
  @override
  final int playerMaxHp;
  @override
  final int monsterHp;
  @override
  final int monsterMaxHp;
  final List<BattleLog> _logs;
  @override
  @JsonKey()
  List<BattleLog> get logs {
    if (_logs is EqualUnmodifiableListView) return _logs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_logs);
  }

  @override
  @JsonKey()
  final int turnCount;
  final List<RewardSummary>? _rewards;
  @override
  List<RewardSummary>? get rewards {
    final value = _rewards;
    if (value == null) return null;
    if (_rewards is EqualUnmodifiableListView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'BattleState(battleId: $battleId, monsterId: $monsterId, status: $status, playerHp: $playerHp, playerMaxHp: $playerMaxHp, monsterHp: $monsterHp, monsterMaxHp: $monsterMaxHp, logs: $logs, turnCount: $turnCount, rewards: $rewards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleStateImpl &&
            (identical(other.battleId, battleId) ||
                other.battleId == battleId) &&
            (identical(other.monsterId, monsterId) ||
                other.monsterId == monsterId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.playerHp, playerHp) ||
                other.playerHp == playerHp) &&
            (identical(other.playerMaxHp, playerMaxHp) ||
                other.playerMaxHp == playerMaxHp) &&
            (identical(other.monsterHp, monsterHp) ||
                other.monsterHp == monsterHp) &&
            (identical(other.monsterMaxHp, monsterMaxHp) ||
                other.monsterMaxHp == monsterMaxHp) &&
            const DeepCollectionEquality().equals(other._logs, _logs) &&
            (identical(other.turnCount, turnCount) ||
                other.turnCount == turnCount) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      battleId,
      monsterId,
      status,
      playerHp,
      playerMaxHp,
      monsterHp,
      monsterMaxHp,
      const DeepCollectionEquality().hash(_logs),
      turnCount,
      const DeepCollectionEquality().hash(_rewards));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleStateImplCopyWith<_$BattleStateImpl> get copyWith =>
      __$$BattleStateImplCopyWithImpl<_$BattleStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleStateImplToJson(
      this,
    );
  }
}

abstract class _BattleState implements BattleState {
  const factory _BattleState(
      {required final String battleId,
      required final String monsterId,
      required final BattleStatus status,
      required final int playerHp,
      required final int playerMaxHp,
      required final int monsterHp,
      required final int monsterMaxHp,
      final List<BattleLog> logs,
      final int turnCount,
      final List<RewardSummary>? rewards}) = _$BattleStateImpl;

  factory _BattleState.fromJson(Map<String, dynamic> json) =
      _$BattleStateImpl.fromJson;

  @override
  String get battleId;
  @override
  String get monsterId;
  @override
  BattleStatus get status;
  @override
  int get playerHp;
  @override
  int get playerMaxHp;
  @override
  int get monsterHp;
  @override
  int get monsterMaxHp;
  @override
  List<BattleLog> get logs;
  @override
  int get turnCount;
  @override
  List<RewardSummary>? get rewards;
  @override
  @JsonKey(ignore: true)
  _$$BattleStateImplCopyWith<_$BattleStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BattleLog _$BattleLogFromJson(Map<String, dynamic> json) {
  return _BattleLog.fromJson(json);
}

/// @nodoc
mixin _$BattleLog {
  String get actorId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  int get damage => throw _privateConstructorUsedError;
  int get remainingHp => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BattleLogCopyWith<BattleLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BattleLogCopyWith<$Res> {
  factory $BattleLogCopyWith(BattleLog value, $Res Function(BattleLog) then) =
      _$BattleLogCopyWithImpl<$Res, BattleLog>;
  @useResult
  $Res call(
      {String actorId,
      String action,
      int damage,
      int remainingHp,
      DateTime timestamp});
}

/// @nodoc
class _$BattleLogCopyWithImpl<$Res, $Val extends BattleLog>
    implements $BattleLogCopyWith<$Res> {
  _$BattleLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actorId = null,
    Object? action = null,
    Object? damage = null,
    Object? remainingHp = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      actorId: null == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
      remainingHp: null == remainingHp
          ? _value.remainingHp
          : remainingHp // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BattleLogImplCopyWith<$Res>
    implements $BattleLogCopyWith<$Res> {
  factory _$$BattleLogImplCopyWith(
          _$BattleLogImpl value, $Res Function(_$BattleLogImpl) then) =
      __$$BattleLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String actorId,
      String action,
      int damage,
      int remainingHp,
      DateTime timestamp});
}

/// @nodoc
class __$$BattleLogImplCopyWithImpl<$Res>
    extends _$BattleLogCopyWithImpl<$Res, _$BattleLogImpl>
    implements _$$BattleLogImplCopyWith<$Res> {
  __$$BattleLogImplCopyWithImpl(
      _$BattleLogImpl _value, $Res Function(_$BattleLogImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actorId = null,
    Object? action = null,
    Object? damage = null,
    Object? remainingHp = null,
    Object? timestamp = null,
  }) {
    return _then(_$BattleLogImpl(
      actorId: null == actorId
          ? _value.actorId
          : actorId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      damage: null == damage
          ? _value.damage
          : damage // ignore: cast_nullable_to_non_nullable
              as int,
      remainingHp: null == remainingHp
          ? _value.remainingHp
          : remainingHp // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BattleLogImpl implements _BattleLog {
  const _$BattleLogImpl(
      {required this.actorId,
      required this.action,
      required this.damage,
      required this.remainingHp,
      required this.timestamp});

  factory _$BattleLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$BattleLogImplFromJson(json);

  @override
  final String actorId;
  @override
  final String action;
  @override
  final int damage;
  @override
  final int remainingHp;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'BattleLog(actorId: $actorId, action: $action, damage: $damage, remainingHp: $remainingHp, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BattleLogImpl &&
            (identical(other.actorId, actorId) || other.actorId == actorId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.damage, damage) || other.damage == damage) &&
            (identical(other.remainingHp, remainingHp) ||
                other.remainingHp == remainingHp) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, actorId, action, damage, remainingHp, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BattleLogImplCopyWith<_$BattleLogImpl> get copyWith =>
      __$$BattleLogImplCopyWithImpl<_$BattleLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BattleLogImplToJson(
      this,
    );
  }
}

abstract class _BattleLog implements BattleLog {
  const factory _BattleLog(
      {required final String actorId,
      required final String action,
      required final int damage,
      required final int remainingHp,
      required final DateTime timestamp}) = _$BattleLogImpl;

  factory _BattleLog.fromJson(Map<String, dynamic> json) =
      _$BattleLogImpl.fromJson;

  @override
  String get actorId;
  @override
  String get action;
  @override
  int get damage;
  @override
  int get remainingHp;
  @override
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$BattleLogImplCopyWith<_$BattleLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RewardSummary _$RewardSummaryFromJson(Map<String, dynamic> json) {
  return _RewardSummary.fromJson(json);
}

/// @nodoc
mixin _$RewardSummary {
  String get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardSummaryCopyWith<RewardSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardSummaryCopyWith<$Res> {
  factory $RewardSummaryCopyWith(
          RewardSummary value, $Res Function(RewardSummary) then) =
      _$RewardSummaryCopyWithImpl<$Res, RewardSummary>;
  @useResult
  $Res call({String type, int amount, String? label});
}

/// @nodoc
class _$RewardSummaryCopyWithImpl<$Res, $Val extends RewardSummary>
    implements $RewardSummaryCopyWith<$Res> {
  _$RewardSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = null,
    Object? label = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RewardSummaryImplCopyWith<$Res>
    implements $RewardSummaryCopyWith<$Res> {
  factory _$$RewardSummaryImplCopyWith(
          _$RewardSummaryImpl value, $Res Function(_$RewardSummaryImpl) then) =
      __$$RewardSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, int amount, String? label});
}

/// @nodoc
class __$$RewardSummaryImplCopyWithImpl<$Res>
    extends _$RewardSummaryCopyWithImpl<$Res, _$RewardSummaryImpl>
    implements _$$RewardSummaryImplCopyWith<$Res> {
  __$$RewardSummaryImplCopyWithImpl(
      _$RewardSummaryImpl _value, $Res Function(_$RewardSummaryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = null,
    Object? label = freezed,
  }) {
    return _then(_$RewardSummaryImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardSummaryImpl implements _RewardSummary {
  const _$RewardSummaryImpl(
      {required this.type, required this.amount, this.label});

  factory _$RewardSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardSummaryImplFromJson(json);

  @override
  final String type;
  @override
  final int amount;
  @override
  final String? label;

  @override
  String toString() {
    return 'RewardSummary(type: $type, amount: $amount, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardSummaryImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, amount, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardSummaryImplCopyWith<_$RewardSummaryImpl> get copyWith =>
      __$$RewardSummaryImplCopyWithImpl<_$RewardSummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardSummaryImplToJson(
      this,
    );
  }
}

abstract class _RewardSummary implements RewardSummary {
  const factory _RewardSummary(
      {required final String type,
      required final int amount,
      final String? label}) = _$RewardSummaryImpl;

  factory _RewardSummary.fromJson(Map<String, dynamic> json) =
      _$RewardSummaryImpl.fromJson;

  @override
  String get type;
  @override
  int get amount;
  @override
  String? get label;
  @override
  @JsonKey(ignore: true)
  _$$RewardSummaryImplCopyWith<_$RewardSummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
