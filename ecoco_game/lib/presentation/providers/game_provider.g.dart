// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authNotifierHash() => r'59602be900ee281c537a101f9c0371e64bbe517b';

/// See also [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AutoDisposeNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>.internal(
  AuthNotifier.new,
  name: r'authNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthNotifier = AutoDisposeNotifier<AsyncValue<UserModel?>>;
String _$currencyNotifierHash() => r'0ad3887d193678a22c142102b9036a2284de1092';

/// See also [CurrencyNotifier].
@ProviderFor(CurrencyNotifier)
final currencyNotifierProvider =
    AutoDisposeNotifierProvider<CurrencyNotifier, CurrencyState>.internal(
  CurrencyNotifier.new,
  name: r'currencyNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currencyNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrencyNotifier = AutoDisposeNotifier<CurrencyState>;
String _$nearbyMonstersNotifierHash() =>
    r'a7482b13d383be0e1b2d6f158bee24d4221255dc';

/// See also [NearbyMonstersNotifier].
@ProviderFor(NearbyMonstersNotifier)
final nearbyMonstersNotifierProvider = AutoDisposeNotifierProvider<
    NearbyMonstersNotifier, AsyncValue<List<MonsterModel>>>.internal(
  NearbyMonstersNotifier.new,
  name: r'nearbyMonstersNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$nearbyMonstersNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NearbyMonstersNotifier
    = AutoDisposeNotifier<AsyncValue<List<MonsterModel>>>;
String _$battleNotifierHash() => r'15788ef692cc6c6fe0ffabfaa2497d61cf229914';

/// See also [BattleNotifier].
@ProviderFor(BattleNotifier)
final battleNotifierProvider =
    AutoDisposeNotifierProvider<BattleNotifier, BattleState?>.internal(
  BattleNotifier.new,
  name: r'battleNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$battleNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BattleNotifier = AutoDisposeNotifier<BattleState?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
