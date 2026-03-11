// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      ecocoPoints: (json['ecocoPoints'] as num).toInt(),
      ecocoCoins: (json['ecocoCoins'] as num).toInt(),
      character:
          CharacterModel.fromJson(json['character'] as Map<String, dynamic>),
      isVip: json['isVip'] as bool,
      vipExpiresAt: json['vipExpiresAt'] == null
          ? null
          : DateTime.parse(json['vipExpiresAt'] as String),
      totalBattlesWon: (json['totalBattlesWon'] as num?)?.toInt() ?? 0,
      totalMonstersDefeated:
          (json['totalMonstersDefeated'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'ecocoPoints': instance.ecocoPoints,
      'ecocoCoins': instance.ecocoCoins,
      'character': instance.character,
      'isVip': instance.isVip,
      'vipExpiresAt': instance.vipExpiresAt?.toIso8601String(),
      'totalBattlesWon': instance.totalBattlesWon,
      'totalMonstersDefeated': instance.totalMonstersDefeated,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$CharacterModelImpl _$$CharacterModelImplFromJson(Map<String, dynamic> json) =>
    _$CharacterModelImpl(
      id: json['id'] as String,
      hp: (json['hp'] as num?)?.toInt() ?? 100,
      maxHp: (json['maxHp'] as num?)?.toInt() ?? 100,
      energy: (json['energy'] as num?)?.toInt() ?? 100,
      maxEnergy: (json['maxEnergy'] as num?)?.toInt() ?? 100,
      attackPower: (json['attackPower'] as num?)?.toInt() ?? 10,
      defense: (json['defense'] as num?)?.toInt() ?? 5,
      skinId: json['skinId'] as String,
      equippedWeaponIds: (json['equippedWeaponIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      inventoryItemIds: (json['inventoryItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CharacterModelImplToJson(
        _$CharacterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hp': instance.hp,
      'maxHp': instance.maxHp,
      'energy': instance.energy,
      'maxEnergy': instance.maxEnergy,
      'attackPower': instance.attackPower,
      'defense': instance.defense,
      'skinId': instance.skinId,
      'equippedWeaponIds': instance.equippedWeaponIds,
      'inventoryItemIds': instance.inventoryItemIds,
    };
