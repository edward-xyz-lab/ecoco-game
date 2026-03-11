abstract class AppConstants {
  static const String appName = 'ECOCO Game';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );
  static const String wsUrl = String.fromEnvironment(
    'WS_URL',
    defaultValue: 'http://localhost:3000',
  );

  // Google Maps
  static const String googleMapsApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_KEY',
    defaultValue: '',
  );

  // Game Balance
  static const int maxHp = 100;
  static const int maxEnergy = 100;
  static const double monsterSpawnRadius = 500.0; // meters
  static const int battleTimeoutSeconds = 30;

  // Currency
  static const int pointsToCoinsRate = 100; // 100點 = 1幣
  static const int batteryRechargeCoins = 5; // 5幣補滿電量
  static const int hpRechargeCoins = 3; // 3幣補滿血量

  // VIP
  static const int vipPriceNtd = 99;
  static const int vipDailyCoins = 20;
  static const double vipBonusMultiplier = 1.5;
}

abstract class StorageKeys {
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String gameMode = 'game_mode';
  static const String onboardingDone = 'onboarding_done';
}

abstract class RouteNames {
  static const String splash = '/';
  static const String modeSelect = '/mode-select';
  static const String normalHome = '/normal';
  static const String gameMap = '/game/map';
  static const String battle = '/game/battle';
  static const String character = '/game/character';
  static const String shop = '/game/shop';
  static const String login = '/auth/login';
  static const String register = '/auth/register';
}
