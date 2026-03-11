import 'package:freezed_annotation/freezed_annotation.dart';

part 'monster_model.freezed.dart';
part 'monster_model.g.dart';

enum MonsterRarity { common, uncommon, rare, epic, legendary }

enum MonsterType { battery, pollution, plastic, corporate, seasonal }

@freezed
class MonsterModel with _$MonsterModel {
  const factory MonsterModel({
    required String id,
    required String name,
    required MonsterRarity rarity,
    required MonsterType type,
    required int hp,
    required int maxHp,
    required int attackPower,
    required int defense,
    required double latitude,
    required double longitude,
    required String stationId,
    required List<RewardModel> rewards,
    String? sponsorName,
    String? sponsorLogoUrl,
    DateTime? expiresAt,
  }) = _MonsterModel;

  factory MonsterModel.fromJson(Map<String, dynamic> json) =>
      _$MonsterModelFromJson(json);
}

@freezed
class RewardModel with _$RewardModel {
  const factory RewardModel({
    required RewardType type,
    required int amount,
    String? itemId,
    String? couponCode,
    String? description,
  }) = _RewardModel;

  factory RewardModel.fromJson(Map<String, dynamic> json) =>
      _$RewardModelFromJson(json);
}

enum RewardType { ecocoCoins, ecocoPoints, coupon, item, equipment }
