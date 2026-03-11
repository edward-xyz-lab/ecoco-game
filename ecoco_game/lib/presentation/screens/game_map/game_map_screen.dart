import 'dart:math';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/monster_model.dart';
import '../../providers/game_provider.dart';
import '../../widgets/common/stat_bar.dart';

// 避免 web 上 import google_maps_flutter 崩潰
export 'game_map_screen.dart';

class GameMapScreen extends ConsumerStatefulWidget {
  const GameMapScreen({super.key});

  @override
  ConsumerState<GameMapScreen> createState() => _GameMapScreenState();
}

class _GameMapScreenState extends ConsumerState<GameMapScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 用 mock 座標，手機版換成 geolocator 取得的真實座標
      ref.read(nearbyMonstersNotifierProvider.notifier).refresh(25.0330, 121.5654);
    });
  }

  void _showMonsterSheet(MonsterModel monster) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => MonsterEncounterSheet(
        monster: monster,
        onFight: () {
          Navigator.pop(context);
          context.push(
            RouteNames.battle,
            extra: {'monsterId': monster.id, 'stationId': monster.stationId},
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final monstersAsync = ref.watch(nearbyMonstersNotifierProvider);
    final monsters = monstersAsync.valueOrNull ?? [];

    return Stack(
      children: [
        // Map layer — web 用假地圖，mobile 用 GoogleMap
        if (kIsWeb)
          _MockMap(monsters: monsters, onMonsterTap: _showMonsterSheet)
        else
          _NativeMap(monsters: monsters, onMonsterTap: _showMonsterSheet),

        // HUD overlay
        SafeArea(
          child: Column(
            children: [
              _buildTopHud().animate().fadeIn().slideY(begin: -0.5),
              const Spacer(),
              _buildBottomControls(monsters).animate().fadeIn().slideY(begin: 0.5),
            ],
          ),
        ),

        if (monstersAsync.isLoading)
          const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      ],
    );
  }

  Widget _buildTopHud() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkBg.withAlpha(230),
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(BorderSide(color: Color(0xFF1E3A5F))),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              gradient: const LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
              ),
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatBar(label: 'HP', value: 75, max: 100, color: AppColors.hpRed),
                const SizedBox(height: 4),
                StatBar(label: '電量', value: 60, max: 100, color: AppColors.energyYellow),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _CurrencyChip(icon: Icons.monetization_on, color: AppColors.coinGold, value: '250'),
              const SizedBox(height: 4),
              _CurrencyChip(icon: Icons.eco, color: AppColors.pointsGreen, value: '1,200'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomControls(List<MonsterModel> monsters) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ControlButton(
            icon: Icons.qr_code_scanner,
            label: '掃描機台',
            color: AppColors.secondary,
            onTap: () {},
          ),
          _ControlButton(
            icon: Icons.my_location,
            label: '定位',
            color: AppColors.primary,
            onTap: () => ref
                .read(nearbyMonstersNotifierProvider.notifier)
                .refresh(25.0330, 121.5654),
          ),
          _ControlButton(
            icon: Icons.refresh,
            label: '刷新 (${monsters.length})',
            color: AppColors.accent,
            onTap: () => ref
                .read(nearbyMonstersNotifierProvider.notifier)
                .refresh(25.0330, 121.5654),
          ),
        ],
      ),
    );
  }
}

// ── Web Mock Map ───────────────────────────────────────────────────────────────

class _MockMap extends StatefulWidget {
  final List<MonsterModel> monsters;
  final void Function(MonsterModel) onMonsterTap;

  const _MockMap({required this.monsters, required this.onMonsterTap});

  @override
  State<_MockMap> createState() => _MockMapState();
}

class _MockMapState extends State<_MockMap> with SingleTickerProviderStateMixin {
  late AnimationController _pulseCtrl;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0A1628)),
      child: Stack(
        children: [
          // Grid background — simulate map tiles
          CustomPaint(
            painter: _MapGridPainter(),
            size: Size.infinite,
          ),

          // Road lines
          CustomPaint(
            painter: _RoadPainter(),
            size: Size.infinite,
          ),

          // Monster markers
          ...widget.monsters.asMap().entries.map((entry) {
            final i = entry.key;
            final m = entry.value;
            final size = MediaQuery.of(context).size;

            // Distribute monsters across visible area
            final positions = [
              Offset(size.width * 0.35, size.height * 0.45),
              Offset(size.width * 0.65, size.height * 0.35),
              Offset(size.width * 0.25, size.height * 0.60),
              Offset(size.width * 0.70, size.height * 0.55),
              Offset(size.width * 0.50, size.height * 0.30),
            ];
            final pos = positions[i % positions.length];

            return Positioned(
              left: pos.dx - 30,
              top: pos.dy - 30,
              child: _MonsterMapPin(
                monster: m,
                pulseCtrl: _pulseCtrl,
                onTap: () => widget.onMonsterTap(m),
              ).animate().fadeIn(delay: Duration(milliseconds: i * 200)).scale(
                    begin: const Offset(0, 0),
                    curve: Curves.bounceOut,
                  ),
            );
          }),

          // Player dot (center)
          Builder(builder: (context) {
            final size = MediaQuery.of(context).size;
            return Positioned(
              left: size.width / 2 - 16,
              top: size.height / 2 - 16,
              child: AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (_, __) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 48 + _pulseCtrl.value * 16,
                      height: 48 + _pulseCtrl.value * 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withAlpha((40 * (1 - _pulseCtrl.value)).toInt()),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withAlpha(150),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.bolt, color: Colors.white, size: 18),
                    ),
                  ],
                ),
              ),
            );
          }),

          // Map label
          const Positioned(
            bottom: 80,
            right: 12,
            child: Text(
              '台北市 · 示意地圖',
              style: TextStyle(color: Color(0xFF546E7A), fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonsterMapPin extends StatelessWidget {
  final MonsterModel monster;
  final AnimationController pulseCtrl;
  final VoidCallback onTap;

  const _MonsterMapPin({
    required this.monster,
    required this.pulseCtrl,
    required this.onTap,
  });

  Color get _color {
    switch (monster.rarity) {
      case MonsterRarity.common:
        return AppColors.rarityCommon;
      case MonsterRarity.uncommon:
        return AppColors.rarityUncommon;
      case MonsterRarity.rare:
        return AppColors.rarityRare;
      case MonsterRarity.epic:
        return AppColors.rarityEpic;
      case MonsterRarity.legendary:
        return AppColors.rarityLegendary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedBuilder(
        animation: pulseCtrl,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: [
            // Pulse ring
            Container(
              width: 56 + pulseCtrl.value * 12,
              height: 56 + pulseCtrl.value * 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color.withAlpha((30 * (1 - pulseCtrl.value)).toInt()),
                border: Border.all(
                  color: _color.withAlpha((80 * (1 - pulseCtrl.value)).toInt()),
                  width: 1,
                ),
              ),
            ),
            // Icon container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _color.withAlpha(30),
                border: Border.all(color: _color, width: 2),
                boxShadow: [
                  BoxShadow(color: _color.withAlpha(100), blurRadius: 8),
                ],
              ),
              child: Icon(_monsterIcon, color: _color, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  IconData get _monsterIcon {
    switch (monster.type) {
      case MonsterType.battery:
        return Icons.battery_alert;
      case MonsterType.pollution:
        return Icons.cloud_off;
      case MonsterType.plastic:
        return Icons.delete;
      case MonsterType.corporate:
        return Icons.business;
      case MonsterType.seasonal:
        return Icons.star;
    }
  }
}

// ── Native map (mobile only) ──────────────────────────────────────────────────

class _NativeMap extends StatelessWidget {
  final List<MonsterModel> monsters;
  final void Function(MonsterModel) onMonsterTap;

  const _NativeMap({required this.monsters, required this.onMonsterTap});

  @override
  Widget build(BuildContext context) {
    // Lazy import — only compiled on non-web
    return const _GoogleMapWrapper();
  }
}

// Stub; actual GoogleMap import is in a separate conditional file
class _GoogleMapWrapper extends StatelessWidget {
  const _GoogleMapWrapper();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A1628),
      child: const Center(
        child: Text('Google Maps (mobile only)', style: TextStyle(color: Colors.white38)),
      ),
    );
  }
}

// ── Map Painters ──────────────────────────────────────────────────────────────

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF112240)
      ..strokeWidth = 1;

    const step = 60.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A2F4A)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final rng = Random(42);
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Horizontal roads
    final hRoads = [0.2, 0.45, 0.5, 0.72];
    for (final r in hRoads) {
      canvas.drawLine(Offset(0, size.height * r), Offset(size.width, size.height * r), paint);
    }

    // Vertical roads
    final vRoads = [0.25, 0.5, 0.55, 0.78];
    for (final r in vRoads) {
      canvas.drawLine(Offset(size.width * r, 0), Offset(size.width * r, size.height), paint);
    }

    // Buildings (rectangles)
    final blockPaint = Paint()..color = const Color(0xFF0F1E35);
    for (int i = 0; i < 12; i++) {
      final bx = rng.nextDouble() * size.width;
      final by = rng.nextDouble() * size.height;
      final bw = 30.0 + rng.nextDouble() * 50;
      final bh = 20.0 + rng.nextDouble() * 40;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(bx, by, bw, bh), const Radius.circular(4)),
        blockPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ── Monster Encounter Sheet ────────────────────────────────────────────────────

class MonsterEncounterSheet extends StatelessWidget {
  final MonsterModel monster;
  final VoidCallback onFight;

  const MonsterEncounterSheet({super.key, required this.monster, required this.onFight});

  Color get _rarityColor {
    switch (monster.rarity) {
      case MonsterRarity.common:
        return AppColors.rarityCommon;
      case MonsterRarity.uncommon:
        return AppColors.rarityUncommon;
      case MonsterRarity.rare:
        return AppColors.rarityRare;
      case MonsterRarity.epic:
        return AppColors.rarityEpic;
      case MonsterRarity.legendary:
        return AppColors.rarityLegendary;
    }
  }

  IconData get _monsterIcon {
    switch (monster.type) {
      case MonsterType.battery:
        return Icons.battery_alert;
      case MonsterType.pollution:
        return Icons.cloud_off;
      case MonsterType.plastic:
        return Icons.delete;
      case MonsterType.corporate:
        return Icons.business;
      case MonsterType.seasonal:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _rarityColor.withAlpha(128), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rarity badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: _rarityColor.withAlpha(50),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: _rarityColor),
            ),
            child: Text(
              monster.rarity.name.toUpperCase(),
              style: TextStyle(
                color: _rarityColor,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _rarityColor.withAlpha(25),
              border: Border.all(color: _rarityColor.withAlpha(128), width: 2),
            ),
            child: Icon(_monsterIcon, color: _rarityColor, size: 44),
          ),
          const SizedBox(height: 12),

          Text(
            monster.name,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(label: 'HP', value: '${monster.hp}', color: AppColors.hpRed),
              const SizedBox(width: 12),
              _StatChip(label: 'ATK', value: '${monster.attackPower}', color: AppColors.accent),
              const SizedBox(width: 12),
              _StatChip(label: 'DEF', value: '${monster.defense}', color: AppColors.secondary),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            '擊敗獎勵',
            style: TextStyle(color: Colors.white.withAlpha(128), fontSize: 12),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: monster.rewards
                .map(
                  (r) => Chip(
                    backgroundColor: AppColors.surfaceDark,
                    label: Text(
                      r.description ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    avatar: Icon(
                      r.type == RewardType.ecocoCoins ? Icons.monetization_on : Icons.card_giftcard,
                      color: AppColors.coinGold,
                      size: 14,
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white54,
                    side: const BorderSide(color: Colors.white24),
                  ),
                  child: const Text('離開'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: onFight,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _rarityColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.flash_on, size: 18),
                      SizedBox(width: 6),
                      Text('前往戰鬥'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().slideY(begin: 0.3, curve: Curves.easeOut);
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withAlpha(100)),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color.withAlpha(179), fontSize: 10)),
          Text(value, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _CurrencyChip extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;

  const _CurrencyChip({required this.icon, required this.color, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(value, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.darkBg.withAlpha(230),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withAlpha(128)),
          boxShadow: [BoxShadow(color: color.withAlpha(50), blurRadius: 12)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
