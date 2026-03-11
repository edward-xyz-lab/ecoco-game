import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../../presentation/screens/home/mode_select_screen.dart';
import '../../presentation/screens/game_map/game_map_screen.dart';
import '../../presentation/screens/battle/battle_screen.dart';
import '../../presentation/screens/character/character_screen.dart';
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.modeSelect,
    routes: [
      GoRoute(
        path: RouteNames.modeSelect,
        builder: (ctx, state) => const ModeSelectScreen(),
      ),
      GoRoute(
        path: RouteNames.normalHome,
        builder: (ctx, state) => const ModeSelectScreen(), // placeholder
      ),
      ShellRoute(
        builder: (ctx, state, child) => GameShell(child: child),
        routes: [
          GoRoute(
            path: RouteNames.gameMap,
            builder: (ctx, state) => const GameMapScreen(),
          ),
          GoRoute(
            path: RouteNames.character,
            builder: (ctx, state) => const CharacterScreen(),
          ),
          GoRoute(
            path: RouteNames.shop,
            builder: (ctx, state) => const ShopScreen(),
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.battle,
        builder: (ctx, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return BattleScreen(
            monsterId: extra?['monsterId'] as String? ?? '',
            stationId: extra?['stationId'] as String? ?? '',
          );
        },
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (ctx, state) => const LoginScreen(),
      ),
    ],
  );
});

class GameShell extends StatelessWidget {
  final Widget child;

  const GameShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: _GameBottomNav(),
    );
  }
}

class _GameBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0A1628),
        border: Border(top: BorderSide(color: Color(0xFF1E3A5F), width: 1)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: const Color(0xFF00C853),
        unselectedItemColor: const Color(0xFF546E7A),
        currentIndex: _indexForLocation(location),
        onTap: (i) => _navigateTo(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: '地圖'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '角色',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: '商店'),
        ],
      ),
    );
  }

  int _indexForLocation(String location) {
    if (location.contains('character')) return 1;
    if (location.contains('shop')) return 2;
    return 0;
  }

  void _navigateTo(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.gameMap);
      case 1:
        context.go(RouteNames.character);
      case 2:
        context.go(RouteNames.shop);
    }
  }
}
