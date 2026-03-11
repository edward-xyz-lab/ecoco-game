// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monster_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MonsterModel _$MonsterModelFromJson(Map<String, dynamic> json) {
  return _MonsterModel.fromJson(json);
}

/// @nodoc
mixin _$MonsterModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  MonsterRarity get rarity => throw _privateConstructorUsedError;
  MonsterType get type => throw _privateConstructorUsedError;
  int get hp => throw _privateConstructorUsedError;
  int get maxHp => throw _privateConstructorUsedError;
  int get attackPower => throw _privateConstructorUsedError;
  int get defense => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get stationId => throw _privateConstructorUsedError;
  List<RewardModel> get rewards => throw _privateConstructorUsedError;
  String? get sponsorName => throw _privateConstructorUsedError;
  String? get sponsorLogoUrl => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonsterModelCopyWith<MonsterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonsterModelCopyWith<$Res> {
  factory $MonsterModelCopyWith(
          MonsterModel value, $Res Function(MonsterModel) then) =
      _$MonsterModelCopyWithImpl<$Res, MonsterModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      MonsterRarity rarity,
      MonsterType type,
      int hp,
      int maxHp,
      int attackPower,
      int defense,
      double latitude,
      double longitude,
      String stationId,
      List<RewardModel> rewards,
      String? sponsorName,
      String? sponsorLogoUrl,
      DateTime? expiresAt});
}

/// @nodoc
class _$MonsterModelCopyWithImpl<$Res, $Val extends MonsterModel>
    implements $MonsterModelCopyWith<$Res> {
  _$MonsterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rarity = null,
    Object? type = null,
    Object? hp = null,
    Object? maxHp = null,
    Object? attackPower = null,
    Object? defense = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? stationId = null,
    Object? rewards = null,
    Object? sponsorName = freezed,
    Object? sponsorLogoUrl = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as MonsterRarity,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MonsterType,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      maxHp: null == maxHp
          ? _value.maxHp
          : maxHp // ignore: cast_nullable_to_non_nullable
              as int,
      attackPower: null == attackPower
          ? _value.attackPower
          : attackPower // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String,
      rewards: null == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardModel>,
      sponsorName: freezed == sponsorName
          ? _value.sponsorName
          : sponsorName // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsorLogoUrl: freezed == sponsorLogoUrl
          ? _value.sponsorLogoUrl
          : sponsorLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonsterModelImplCopyWith<$Res>
    implements $MonsterModelCopyWith<$Res> {
  factory _$$MonsterModelImplCopyWith(
          _$MonsterModelImpl value, $Res Function(_$MonsterModelImpl) then) =
      __$$MonsterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      MonsterRarity rarity,
      MonsterType type,
      int hp,
      int maxHp,
      int attackPower,
      int defense,
      double latitude,
      double longitude,
      String stationId,
      List<RewardModel> rewards,
      String? sponsorName,
      String? sponsorLogoUrl,
      DateTime? expiresAt});
}

/// @nodoc
class __$$MonsterModelImplCopyWithImpl<$Res>
    extends _$MonsterModelCopyWithImpl<$Res, _$MonsterModelImpl>
    implements _$$MonsterModelImplCopyWith<$Res> {
  __$$MonsterModelImplCopyWithImpl(
      _$MonsterModelImpl _value, $Res Function(_$MonsterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rarity = null,
    Object? type = null,
    Object? hp = null,
    Object? maxHp = null,
    Object? attackPower = null,
    Object? defense = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? stationId = null,
    Object? rewards = null,
    Object? sponsorName = freezed,
    Object? sponsorLogoUrl = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$MonsterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rarity: null == rarity
          ? _value.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as MonsterRarity,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MonsterType,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      maxHp: null == maxHp
          ? _value.maxHp
          : maxHp // ignore: cast_nullable_to_non_nullable
              as int,
      attackPower: null == attackPower
          ? _value.attackPower
          : attackPower // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      stationId: null == stationId
          ? _value.stationId
          : stationId // ignore: cast_nullable_to_non_nullable
              as String,
      rewards: null == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as List<RewardModel>,
      sponsorName: freezed == sponsorName
          ? _value.sponsorName
          : sponsorName // ignore: cast_nullable_to_non_nullable
              as String?,
      sponsorLogoUrl: freezed == sponsorLogoUrl
          ? _value.sponsorLogoUrl
          : sponsorLogoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonsterModelImpl implements _MonsterModel {
  const _$MonsterModelImpl(
      {required this.id,
      required this.name,
      required this.rarity,
      required this.type,
      required this.hp,
      required this.maxHp,
      required this.attackPower,
      required this.defense,
      required this.latitude,
      required this.longitude,
      required this.stationId,
      required final List<RewardModel> rewards,
      this.sponsorName,
      this.sponsorLogoUrl,
      this.expiresAt})
      : _rewards = rewards;

  factory _$MonsterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonsterModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final MonsterRarity rarity;
  @override
  final MonsterType type;
  @override
  final int hp;
  @override
  final int maxHp;
  @override
  final int attackPower;
  @override
  final int defense;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String stationId;
  final List<RewardModel> _rewards;
  @override
  List<RewardModel> get rewards {
    if (_rewards is EqualUnmodifiableListView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_rewards);
  }

  @override
  final String? sponsorName;
  @override
  final String? sponsorLogoUrl;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'MonsterModel(id: $id, name: $name, rarity: $rarity, type: $type, hp: $hp, maxHp: $maxHp, attackPower: $attackPower, defense: $defense, latitude: $latitude, longitude: $longitude, stationId: $stationId, rewards: $rewards, sponsorName: $sponsorName, sponsorLogoUrl: $sponsorLogoUrl, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonsterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.maxHp, maxHp) || other.maxHp == maxHp) &&
            (identical(other.attackPower, attackPower) ||
                other.attackPower == attackPower) &&
            (identical(other.defense, defense) || other.defense == defense) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.stationId, stationId) ||
                other.stationId == stationId) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards) &&
            (identical(other.sponsorName, sponsorName) ||
                other.sponsorName == sponsorName) &&
            (identical(other.sponsorLogoUrl, sponsorLogoUrl) ||
                other.sponsorLogoUrl == sponsorLogoUrl) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      rarity,
      type,
      hp,
      maxHp,
      attackPower,
      defense,
      latitude,
      longitude,
      stationId,
      const DeepCollectionEquality().hash(_rewards),
      sponsorName,
      sponsorLogoUrl,
      expiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MonsterModelImplCopyWith<_$MonsterModelImpl> get copyWith =>
      __$$MonsterModelImplCopyWithImpl<_$MonsterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonsterModelImplToJson(
      this,
    );
  }
}

abstract class _MonsterModel implements MonsterModel {
  const factory _MonsterModel(
      {required final String id,
      required final String name,
      required final MonsterRarity rarity,
      required final MonsterType type,
      required final int hp,
      required final int maxHp,
      required final int attackPower,
      required final int defense,
      required final double latitude,
      required final double longitude,
      required final String stationId,
      required final List<RewardModel> rewards,
      final String? sponsorName,
      final String? sponsorLogoUrl,
      final DateTime? expiresAt}) = _$MonsterModelImpl;

  factory _MonsterModel.fromJson(Map<String, dynamic> json) =
      _$MonsterModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  MonsterRarity get rarity;
  @override
  MonsterType get type;
  @override
  int get hp;
  @override
  int get maxHp;
  @override
  int get attackPower;
  @override
  int get defense;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get stationId;
  @override
  List<RewardModel> get rewards;
  @override
  String? get sponsorName;
  @override
  String? get sponsorLogoUrl;
  @override
  DateTime? get expiresAt;
  @override
  @JsonKey(ignore: true)
  _$$MonsterModelImplCopyWith<_$MonsterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RewardModel _$RewardModelFromJson(Map<String, dynamic> json) {
  return _RewardModel.fromJson(json);
}

/// @nodoc
mixin _$RewardModel {
  RewardType get type => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  String? get itemId => throw _privateConstructorUsedError;
  String? get couponCode => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RewardModelCopyWith<RewardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardModelCopyWith<$Res> {
  factory $RewardModelCopyWith(
          RewardModel value, $Res Function(RewardModel) then) =
      _$RewardModelCopyWithImpl<$Res, RewardModel>;
  @useResult
  $Res call(
      {RewardType type,
      int amount,
      String? itemId,
      String? couponCode,
      String? description});
}

/// @nodoc
class _$RewardModelCopyWithImpl<$Res, $Val extends RewardModel>
    implements $RewardModelCopyWith<$Res> {
  _$RewardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = null,
    Object? itemId = freezed,
    Object? couponCode = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RewardType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RewardModelImplCopyWith<$Res>
    implements $RewardModelCopyWith<$Res> {
  factory _$$RewardModelImplCopyWith(
          _$RewardModelImpl value, $Res Function(_$RewardModelImpl) then) =
      __$$RewardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RewardType type,
      int amount,
      String? itemId,
      String? couponCode,
      String? description});
}

/// @nodoc
class __$$RewardModelImplCopyWithImpl<$Res>
    extends _$RewardModelCopyWithImpl<$Res, _$RewardModelImpl>
    implements _$$RewardModelImplCopyWith<$Res> {
  __$$RewardModelImplCopyWithImpl(
      _$RewardModelImpl _value, $Res Function(_$RewardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? amount = null,
    Object? itemId = freezed,
    Object? couponCode = freezed,
    Object? description = freezed,
  }) {
    return _then(_$RewardModelImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as RewardType,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      itemId: freezed == itemId
          ? _value.itemId
          : itemId // ignore: cast_nullable_to_non_nullable
              as String?,
      couponCode: freezed == couponCode
          ? _value.couponCode
          : couponCode // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RewardModelImpl implements _RewardModel {
  const _$RewardModelImpl(
      {required this.type,
      required this.amount,
      this.itemId,
      this.couponCode,
      this.description});

  factory _$RewardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RewardModelImplFromJson(json);

  @override
  final RewardType type;
  @override
  final int amount;
  @override
  final String? itemId;
  @override
  final String? couponCode;
  @override
  final String? description;

  @override
  String toString() {
    return 'RewardModel(type: $type, amount: $amount, itemId: $itemId, couponCode: $couponCode, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RewardModelImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.itemId, itemId) || other.itemId == itemId) &&
            (identical(other.couponCode, couponCode) ||
                other.couponCode == couponCode) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, amount, itemId, couponCode, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RewardModelImplCopyWith<_$RewardModelImpl> get copyWith =>
      __$$RewardModelImplCopyWithImpl<_$RewardModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RewardModelImplToJson(
      this,
    );
  }
}

abstract class _RewardModel implements RewardModel {
  const factory _RewardModel(
      {required final RewardType type,
      required final int amount,
      final String? itemId,
      final String? couponCode,
      final String? description}) = _$RewardModelImpl;

  factory _RewardModel.fromJson(Map<String, dynamic> json) =
      _$RewardModelImpl.fromJson;

  @override
  RewardType get type;
  @override
  int get amount;
  @override
  String? get itemId;
  @override
  String? get couponCode;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$RewardModelImplCopyWith<_$RewardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
