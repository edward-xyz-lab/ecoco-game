import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String username,
    required String email,
    required int ecocoPoints,
    required int ecocoCoins,
    required CharacterModel character,
    required bool isVip,
    DateTime? vipExpiresAt,
    @Default(0) int totalBattlesWon,
    @Default(0) int totalMonstersDefeated,
    required DateTime createdAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    required String id,
    @Default(100) int hp,
    @Default(100) int maxHp,
    @Default(100) int energy,
    @Default(100) int maxEnergy,
    @Default(10) int attackPower,
    @Default(5) int defense,
    required String skinId,
    @Default([]) List<String> equippedWeaponIds,
    @Default([]) List<String> inventoryItemIds,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}
