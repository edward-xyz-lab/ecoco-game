// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monster_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MonsterModelImpl _$$MonsterModelImplFromJson(Map<String, dynamic> json) =>
    _$MonsterModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      rarity: $enumDecode(_$MonsterRarityEnumMap, json['rarity']),
      type: $enumDecode(_$MonsterTypeEnumMap, json['type']),
      hp: (json['hp'] as num).toInt(),
      maxHp: (json['maxHp'] as num).toInt(),
      attackPower: (json['attackPower'] as num).toInt(),
      defense: (json['defense'] as num).toInt(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      stationId: json['stationId'] as String,
      rewards: (json['rewards'] as List<dynamic>)
          .map((e) => RewardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      sponsorName: json['sponsorName'] as String?,
      sponsorLogoUrl: json['sponsorLogoUrl'] as String?,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$MonsterModelImplToJson(_$MonsterModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rarity': _$MonsterRarityEnumMap[instance.rarity]!,
      'type': _$MonsterTypeEnumMap[instance.type]!,
      'hp': instance.hp,
      'maxHp': instance.maxHp,
      'attackPower': instance.attackPower,
      'defense': instance.defense,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'stationId': instance.stationId,
      'rewards': instance.rewards,
      'sponsorName': instance.sponsorName,
      'sponsorLogoUrl': instance.sponsorLogoUrl,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

const _$MonsterRarityEnumMap = {
  MonsterRarity.common: 'common',
  MonsterRarity.uncommon: 'uncommon',
  MonsterRarity.rare: 'rare',
  MonsterRarity.epic: 'epic',
  MonsterRarity.legendary: 'legendary',
};

const _$MonsterTypeEnumMap = {
  MonsterType.battery: 'battery',
  MonsterType.pollution: 'pollution',
  MonsterType.plastic: 'plastic',
  MonsterType.corporate: 'corporate',
  MonsterType.seasonal: 'seasonal',
};

_$RewardModelImpl _$$RewardModelImplFromJson(Map<String, dynamic> json) =>
    _$RewardModelImpl(
      type: $enumDecode(_$RewardTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toInt(),
      itemId: json['itemId'] as String?,
      couponCode: json['couponCode'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$RewardModelImplToJson(_$RewardModelImpl instance) =>
    <String, dynamic>{
      'type': _$RewardTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'itemId': instance.itemId,
      'couponCode': instance.couponCode,
      'description': instance.description,
    };

const _$RewardTypeEnumMap = {
  RewardType.ecocoCoins: 'ecocoCoins',
  RewardType.ecocoPoints: 'ecocoPoints',
  RewardType.coupon: 'coupon',
  RewardType.item: 'item',
  RewardType.equipment: 'equipment',
};
