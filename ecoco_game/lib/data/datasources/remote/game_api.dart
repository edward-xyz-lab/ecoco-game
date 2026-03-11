import 'package:dio/dio.dart';
import '../../models/monster_model.dart';
import '../../models/battle_model.dart';
import '../../models/user_model.dart';

class GameApi {
  final Dio _dio;

  GameApi(this._dio);

  // ── Auth ────────────────────────────────────────────────────────────────────

  Future<AuthResponse> register(Map<String, dynamic> body) async {
    final r = await _dio.post('/auth/register', data: body);
    return AuthResponse.fromJson(r.data as Map<String, dynamic>);
  }

  Future<AuthResponse> login(Map<String, dynamic> body) async {
    final r = await _dio.post('/auth/login', data: body);
    return AuthResponse.fromJson(r.data as Map<String, dynamic>);
  }

  // ── User ─────────────────────────────────────────────────────────────────────

  Future<UserModel> getMe() async {
    final r = await _dio.get('/users/me');
    return UserModel.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CharacterModel> updateCharacter(Map<String, dynamic> body) async {
    final r = await _dio.patch('/users/me/character', data: body);
    return CharacterModel.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Monsters ─────────────────────────────────────────────────────────────────

  Future<List<MonsterModel>> getNearbyMonsters(double lat, double lng, double radius) async {
    final r = await _dio.get('/monsters/nearby', queryParameters: {
      'lat': lat,
      'lng': lng,
      'radius': radius,
    });
    return (r.data as List).map((e) => MonsterModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<MonsterModel> getMonster(String id) async {
    final r = await _dio.get('/monsters/$id');
    return MonsterModel.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Battle ───────────────────────────────────────────────────────────────────

  Future<BattleState> startBattle(Map<String, dynamic> body) async {
    final r = await _dio.post('/battles/start', data: body);
    return BattleState.fromJson(r.data as Map<String, dynamic>);
  }

  Future<BattleState> performAction(String battleId, Map<String, dynamic> body) async {
    final r = await _dio.post('/battles/$battleId/action', data: body);
    return BattleState.fromJson(r.data as Map<String, dynamic>);
  }

  Future<BattleState> getBattleState(String battleId) async {
    final r = await _dio.get('/battles/$battleId');
    return BattleState.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Currency ─────────────────────────────────────────────────────────────────

  Future<CurrencyResponse> convertPointsToCoins(Map<String, dynamic> body) async {
    final r = await _dio.post('/currency/convert-points', data: body);
    return CurrencyResponse.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CharacterModel> rechargeEnergy() async {
    final r = await _dio.post('/currency/recharge-energy');
    return CharacterModel.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CharacterModel> rechargeHp() async {
    final r = await _dio.post('/currency/recharge-hp');
    return CharacterModel.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Shop ─────────────────────────────────────────────────────────────────────

  Future<List<ShopItem>> getShopItems() async {
    final r = await _dio.get('/shop/items');
    return (r.data as List).map((e) => ShopItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<PurchaseResult> purchaseItem(Map<String, dynamic> body) async {
    final r = await _dio.post('/shop/purchase', data: body);
    return PurchaseResult.fromJson(r.data as Map<String, dynamic>);
  }

  // ── Stations ─────────────────────────────────────────────────────────────────

  Future<ScanResult> scanStation(String stationId, String action) async {
    final r = await _dio.post('/stations/$stationId/scan', data: {'action': action});
    return ScanResult.fromJson(r.data as Map<String, dynamic>);
  }
}

// ── Response models ───────────────────────────────────────────────────────────

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  AuthResponse({required this.accessToken, required this.refreshToken, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      );
}

class CurrencyResponse {
  final int ecocoPoints;
  final int ecocoCoins;

  CurrencyResponse({required this.ecocoPoints, required this.ecocoCoins});

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) => CurrencyResponse(
        ecocoPoints: json['ecocoPoints'] as int,
        ecocoCoins: json['ecocoCoins'] as int,
      );
}

class ShopItem {
  final String id;
  final String name;
  final String description;
  final String type;
  final int coinPrice;
  final String? imageUrl;

  ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.coinPrice,
    this.imageUrl,
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) => ShopItem(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        type: json['type'] as String,
        coinPrice: json['coinPrice'] as int,
        imageUrl: json['imageUrl'] as String?,
      );
}

class PurchaseResult {
  final bool success;
  final String itemId;
  final int remainingCoins;

  PurchaseResult({required this.success, required this.itemId, required this.remainingCoins});

  factory PurchaseResult.fromJson(Map<String, dynamic> json) => PurchaseResult(
        success: json['success'] as bool,
        itemId: json['itemId'] as String,
        remainingCoins: json['remainingCoins'] as int,
      );
}

class ScanResult {
  final bool valid;
  final String stationId;
  final String? monsterId;
  final String message;

  ScanResult({required this.valid, required this.stationId, this.monsterId, required this.message});

  factory ScanResult.fromJson(Map<String, dynamic> json) => ScanResult(
        valid: json['valid'] as bool,
        stationId: json['stationId'] as String,
        monsterId: json['monsterId'] as String?,
        message: json['message'] as String,
      );
}
