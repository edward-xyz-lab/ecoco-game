// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get ecocoPoints => throw _privateConstructorUsedError;
  int get ecocoCoins => throw _privateConstructorUsedError;
  CharacterModel get character => throw _privateConstructorUsedError;
  bool get isVip => throw _privateConstructorUsedError;
  DateTime? get vipExpiresAt => throw _privateConstructorUsedError;
  int get totalBattlesWon => throw _privateConstructorUsedError;
  int get totalMonstersDefeated => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      int ecocoPoints,
      int ecocoCoins,
      CharacterModel character,
      bool isVip,
      DateTime? vipExpiresAt,
      int totalBattlesWon,
      int totalMonstersDefeated,
      DateTime createdAt});

  $CharacterModelCopyWith<$Res> get character;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? ecocoPoints = null,
    Object? ecocoCoins = null,
    Object? character = null,
    Object? isVip = null,
    Object? vipExpiresAt = freezed,
    Object? totalBattlesWon = null,
    Object? totalMonstersDefeated = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ecocoPoints: null == ecocoPoints
          ? _value.ecocoPoints
          : ecocoPoints // ignore: cast_nullable_to_non_nullable
              as int,
      ecocoCoins: null == ecocoCoins
          ? _value.ecocoCoins
          : ecocoCoins // ignore: cast_nullable_to_non_nullable
              as int,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterModel,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      vipExpiresAt: freezed == vipExpiresAt
          ? _value.vipExpiresAt
          : vipExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalBattlesWon: null == totalBattlesWon
          ? _value.totalBattlesWon
          : totalBattlesWon // ignore: cast_nullable_to_non_nullable
              as int,
      totalMonstersDefeated: null == totalMonstersDefeated
          ? _value.totalMonstersDefeated
          : totalMonstersDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CharacterModelCopyWith<$Res> get character {
    return $CharacterModelCopyWith<$Res>(_value.character, (value) {
      return _then(_value.copyWith(character: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      int ecocoPoints,
      int ecocoCoins,
      CharacterModel character,
      bool isVip,
      DateTime? vipExpiresAt,
      int totalBattlesWon,
      int totalMonstersDefeated,
      DateTime createdAt});

  @override
  $CharacterModelCopyWith<$Res> get character;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? ecocoPoints = null,
    Object? ecocoCoins = null,
    Object? character = null,
    Object? isVip = null,
    Object? vipExpiresAt = freezed,
    Object? totalBattlesWon = null,
    Object? totalMonstersDefeated = null,
    Object? createdAt = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      ecocoPoints: null == ecocoPoints
          ? _value.ecocoPoints
          : ecocoPoints // ignore: cast_nullable_to_non_nullable
              as int,
      ecocoCoins: null == ecocoCoins
          ? _value.ecocoCoins
          : ecocoCoins // ignore: cast_nullable_to_non_nullable
              as int,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as CharacterModel,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      vipExpiresAt: freezed == vipExpiresAt
          ? _value.vipExpiresAt
          : vipExpiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      totalBattlesWon: null == totalBattlesWon
          ? _value.totalBattlesWon
          : totalBattlesWon // ignore: cast_nullable_to_non_nullable
              as int,
      totalMonstersDefeated: null == totalMonstersDefeated
          ? _value.totalMonstersDefeated
          : totalMonstersDefeated // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.username,
      required this.email,
      required this.ecocoPoints,
      required this.ecocoCoins,
      required this.character,
      required this.isVip,
      this.vipExpiresAt,
      this.totalBattlesWon = 0,
      this.totalMonstersDefeated = 0,
      required this.createdAt});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final int ecocoPoints;
  @override
  final int ecocoCoins;
  @override
  final CharacterModel character;
  @override
  final bool isVip;
  @override
  final DateTime? vipExpiresAt;
  @override
  @JsonKey()
  final int totalBattlesWon;
  @override
  @JsonKey()
  final int totalMonstersDefeated;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, ecocoPoints: $ecocoPoints, ecocoCoins: $ecocoCoins, character: $character, isVip: $isVip, vipExpiresAt: $vipExpiresAt, totalBattlesWon: $totalBattlesWon, totalMonstersDefeated: $totalMonstersDefeated, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.ecocoPoints, ecocoPoints) ||
                other.ecocoPoints == ecocoPoints) &&
            (identical(other.ecocoCoins, ecocoCoins) ||
                other.ecocoCoins == ecocoCoins) &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.isVip, isVip) || other.isVip == isVip) &&
            (identical(other.vipExpiresAt, vipExpiresAt) ||
                other.vipExpiresAt == vipExpiresAt) &&
            (identical(other.totalBattlesWon, totalBattlesWon) ||
                other.totalBattlesWon == totalBattlesWon) &&
            (identical(other.totalMonstersDefeated, totalMonstersDefeated) ||
                other.totalMonstersDefeated == totalMonstersDefeated) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      username,
      email,
      ecocoPoints,
      ecocoCoins,
      character,
      isVip,
      vipExpiresAt,
      totalBattlesWon,
      totalMonstersDefeated,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String username,
      required final String email,
      required final int ecocoPoints,
      required final int ecocoCoins,
      required final CharacterModel character,
      required final bool isVip,
      final DateTime? vipExpiresAt,
      final int totalBattlesWon,
      final int totalMonstersDefeated,
      required final DateTime createdAt}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  int get ecocoPoints;
  @override
  int get ecocoCoins;
  @override
  CharacterModel get character;
  @override
  bool get isVip;
  @override
  DateTime? get vipExpiresAt;
  @override
  int get totalBattlesWon;
  @override
  int get totalMonstersDefeated;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CharacterModel _$CharacterModelFromJson(Map<String, dynamic> json) {
  return _CharacterModel.fromJson(json);
}

/// @nodoc
mixin _$CharacterModel {
  String get id => throw _privateConstructorUsedError;
  int get hp => throw _privateConstructorUsedError;
  int get maxHp => throw _privateConstructorUsedError;
  int get energy => throw _privateConstructorUsedError;
  int get maxEnergy => throw _privateConstructorUsedError;
  int get attackPower => throw _privateConstructorUsedError;
  int get defense => throw _privateConstructorUsedError;
  String get skinId => throw _privateConstructorUsedError;
  List<String> get equippedWeaponIds => throw _privateConstructorUsedError;
  List<String> get inventoryItemIds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CharacterModelCopyWith<CharacterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CharacterModelCopyWith<$Res> {
  factory $CharacterModelCopyWith(
          CharacterModel value, $Res Function(CharacterModel) then) =
      _$CharacterModelCopyWithImpl<$Res, CharacterModel>;
  @useResult
  $Res call(
      {String id,
      int hp,
      int maxHp,
      int energy,
      int maxEnergy,
      int attackPower,
      int defense,
      String skinId,
      List<String> equippedWeaponIds,
      List<String> inventoryItemIds});
}

/// @nodoc
class _$CharacterModelCopyWithImpl<$Res, $Val extends CharacterModel>
    implements $CharacterModelCopyWith<$Res> {
  _$CharacterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hp = null,
    Object? maxHp = null,
    Object? energy = null,
    Object? maxEnergy = null,
    Object? attackPower = null,
    Object? defense = null,
    Object? skinId = null,
    Object? equippedWeaponIds = null,
    Object? inventoryItemIds = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      maxHp: null == maxHp
          ? _value.maxHp
          : maxHp // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      maxEnergy: null == maxEnergy
          ? _value.maxEnergy
          : maxEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      attackPower: null == attackPower
          ? _value.attackPower
          : attackPower // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      skinId: null == skinId
          ? _value.skinId
          : skinId // ignore: cast_nullable_to_non_nullable
              as String,
      equippedWeaponIds: null == equippedWeaponIds
          ? _value.equippedWeaponIds
          : equippedWeaponIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inventoryItemIds: null == inventoryItemIds
          ? _value.inventoryItemIds
          : inventoryItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CharacterModelImplCopyWith<$Res>
    implements $CharacterModelCopyWith<$Res> {
  factory _$$CharacterModelImplCopyWith(_$CharacterModelImpl value,
          $Res Function(_$CharacterModelImpl) then) =
      __$$CharacterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int hp,
      int maxHp,
      int energy,
      int maxEnergy,
      int attackPower,
      int defense,
      String skinId,
      List<String> equippedWeaponIds,
      List<String> inventoryItemIds});
}

/// @nodoc
class __$$CharacterModelImplCopyWithImpl<$Res>
    extends _$CharacterModelCopyWithImpl<$Res, _$CharacterModelImpl>
    implements _$$CharacterModelImplCopyWith<$Res> {
  __$$CharacterModelImplCopyWithImpl(
      _$CharacterModelImpl _value, $Res Function(_$CharacterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? hp = null,
    Object? maxHp = null,
    Object? energy = null,
    Object? maxEnergy = null,
    Object? attackPower = null,
    Object? defense = null,
    Object? skinId = null,
    Object? equippedWeaponIds = null,
    Object? inventoryItemIds = null,
  }) {
    return _then(_$CharacterModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      hp: null == hp
          ? _value.hp
          : hp // ignore: cast_nullable_to_non_nullable
              as int,
      maxHp: null == maxHp
          ? _value.maxHp
          : maxHp // ignore: cast_nullable_to_non_nullable
              as int,
      energy: null == energy
          ? _value.energy
          : energy // ignore: cast_nullable_to_non_nullable
              as int,
      maxEnergy: null == maxEnergy
          ? _value.maxEnergy
          : maxEnergy // ignore: cast_nullable_to_non_nullable
              as int,
      attackPower: null == attackPower
          ? _value.attackPower
          : attackPower // ignore: cast_nullable_to_non_nullable
              as int,
      defense: null == defense
          ? _value.defense
          : defense // ignore: cast_nullable_to_non_nullable
              as int,
      skinId: null == skinId
          ? _value.skinId
          : skinId // ignore: cast_nullable_to_non_nullable
              as String,
      equippedWeaponIds: null == equippedWeaponIds
          ? _value._equippedWeaponIds
          : equippedWeaponIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      inventoryItemIds: null == inventoryItemIds
          ? _value._inventoryItemIds
          : inventoryItemIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CharacterModelImpl implements _CharacterModel {
  const _$CharacterModelImpl(
      {required this.id,
      this.hp = 100,
      this.maxHp = 100,
      this.energy = 100,
      this.maxEnergy = 100,
      this.attackPower = 10,
      this.defense = 5,
      required this.skinId,
      final List<String> equippedWeaponIds = const [],
      final List<String> inventoryItemIds = const []})
      : _equippedWeaponIds = equippedWeaponIds,
        _inventoryItemIds = inventoryItemIds;

  factory _$CharacterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CharacterModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final int hp;
  @override
  @JsonKey()
  final int maxHp;
  @override
  @JsonKey()
  final int energy;
  @override
  @JsonKey()
  final int maxEnergy;
  @override
  @JsonKey()
  final int attackPower;
  @override
  @JsonKey()
  final int defense;
  @override
  final String skinId;
  final List<String> _equippedWeaponIds;
  @override
  @JsonKey()
  List<String> get equippedWeaponIds {
    if (_equippedWeaponIds is EqualUnmodifiableListView)
      return _equippedWeaponIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_equippedWeaponIds);
  }

  final List<String> _inventoryItemIds;
  @override
  @JsonKey()
  List<String> get inventoryItemIds {
    if (_inventoryItemIds is EqualUnmodifiableListView)
      return _inventoryItemIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inventoryItemIds);
  }

  @override
  String toString() {
    return 'CharacterModel(id: $id, hp: $hp, maxHp: $maxHp, energy: $energy, maxEnergy: $maxEnergy, attackPower: $attackPower, defense: $defense, skinId: $skinId, equippedWeaponIds: $equippedWeaponIds, inventoryItemIds: $inventoryItemIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CharacterModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hp, hp) || other.hp == hp) &&
            (identical(other.maxHp, maxHp) || other.maxHp == maxHp) &&
            (identical(other.energy, energy) || other.energy == energy) &&
            (identical(other.maxEnergy, maxEnergy) ||
                other.maxEnergy == maxEnergy) &&
            (identical(other.attackPower, attackPower) ||
                other.attackPower == attackPower) &&
            (identical(other.defense, defense) || other.defense == defense) &&
            (identical(other.skinId, skinId) || other.skinId == skinId) &&
            const DeepCollectionEquality()
                .equals(other._equippedWeaponIds, _equippedWeaponIds) &&
            const DeepCollectionEquality()
                .equals(other._inventoryItemIds, _inventoryItemIds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      hp,
      maxHp,
      energy,
      maxEnergy,
      attackPower,
      defense,
      skinId,
      const DeepCollectionEquality().hash(_equippedWeaponIds),
      const DeepCollectionEquality().hash(_inventoryItemIds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CharacterModelImplCopyWith<_$CharacterModelImpl> get copyWith =>
      __$$CharacterModelImplCopyWithImpl<_$CharacterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CharacterModelImplToJson(
      this,
    );
  }
}

abstract class _CharacterModel implements CharacterModel {
  const factory _CharacterModel(
      {required final String id,
      final int hp,
      final int maxHp,
      final int energy,
      final int maxEnergy,
      final int attackPower,
      final int defense,
      required final String skinId,
      final List<String> equippedWeaponIds,
      final List<String> inventoryItemIds}) = _$CharacterModelImpl;

  factory _CharacterModel.fromJson(Map<String, dynamic> json) =
      _$CharacterModelImpl.fromJson;

  @override
  String get id;
  @override
  int get hp;
  @override
  int get maxHp;
  @override
  int get energy;
  @override
  int get maxEnergy;
  @override
  int get attackPower;
  @override
  int get defense;
  @override
  String get skinId;
  @override
  List<String> get equippedWeaponIds;
  @override
  List<String> get inventoryItemIds;
  @override
  @JsonKey(ignore: true)
  _$$CharacterModelImplCopyWith<_$CharacterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
