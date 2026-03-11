import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedSkinIndex = 0;

  final List<_SkinData> _skins = [
    _SkinData('環保戰士', Icons.eco, AppColors.primary, 0),
    _SkinData('太空電池人', Icons.rocket_launch, AppColors.secondary, 120),
    _SkinData('回收忍者', Icons.dangerous, Colors.purple, 200),
    _SkinData('聖誕版', Icons.star, Colors.red, 300),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: const Text('我的角色'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: AppColors.coinGold, size: 18),
                const SizedBox(width: 4),
                const Text(
                  '250',
                  style: TextStyle(
                    color: AppColors.coinGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '外觀'),
            Tab(text: '武器'),
            Tab(text: '道具'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Character preview
          _buildCharacterPreview(),
          // Stats
          _buildStatsRow(),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSkinsTab(),
                _buildWeaponsTab(),
                _buildItemsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterPreview() {
    final skin = _skins[_selectedSkinIndex];
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [skin.color.withOpacity(0.2), Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: skin.color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [skin.color.withOpacity(0.3), skin.color.withOpacity(0.1)],
              ),
              border: Border.all(color: skin.color, width: 2),
              boxShadow: [
                BoxShadow(color: skin.color.withOpacity(0.4), blurRadius: 20),
              ],
            ),
            child: Icon(skin.icon, color: skin.color, size: 56),
          ).animate(onPlay: (c) => c.repeat()).shimmer(
                duration: 2000.ms,
                color: skin.color.withOpacity(0.3),
              ),
          const SizedBox(height: 12),
          Text(
            skin.name,
            style: TextStyle(
              color: skin.color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _StatCard(label: '攻擊', value: '25', color: AppColors.accent),
          const SizedBox(width: 8),
          _StatCard(label: '防禦', value: '12', color: AppColors.secondary),
          const SizedBox(width: 8),
          _StatCard(label: '勝場', value: '47', color: AppColors.primary),
          const SizedBox(width: 8),
          _StatCard(label: '連勝', value: '5', color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildSkinsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: _skins.length,
      itemBuilder: (_, i) {
        final skin = _skins[i];
        final isSelected = i == _selectedSkinIndex;
        final isOwned = skin.coinPrice == 0;

        return GestureDetector(
          onTap: isOwned ? () => setState(() => _selectedSkinIndex = i) : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: AppColors.cardDark,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? skin.color : const Color(0xFF1E3A5F),
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: skin.color.withOpacity(0.3), blurRadius: 12)]
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(skin.icon, color: skin.color, size: 48),
                const SizedBox(height: 8),
                Text(
                  skin.name,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
                const SizedBox(height: 6),
                if (isOwned)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      isSelected ? '使用中' : '已擁有',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.monetization_on, color: AppColors.coinGold, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${skin.coinPrice}',
                        style: const TextStyle(color: AppColors.coinGold, fontSize: 13),
                      ),
                    ],
                  ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: i * 80)),
        );
      },
    );
  }

  Widget _buildWeaponsTab() {
    final weapons = [
      _WeaponData('電池砲', Icons.battery_charging_full, 15, AppColors.primary, true),
      _WeaponData('清潔槍', Icons.cleaning_services, 20, AppColors.secondary, false, 150),
      _WeaponData('回收雷射', Icons.recycling, 30, Colors.purple, false, 300),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: weapons.length,
      itemBuilder: (_, i) {
        final w = weapons[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: w.isEquipped ? w.color : const Color(0xFF1E3A5F),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: w.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(w.icon, color: w.color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      w.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ATK +${w.atk}',
                      style: TextStyle(color: w.color, fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (w.isEquipped)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: w.color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '裝備中',
                    style: TextStyle(color: w.color, fontSize: 12),
                  ),
                )
              else if (w.coinPrice != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.monetization_on, color: AppColors.coinGold, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '${w.coinPrice}',
                      style: const TextStyle(color: AppColors.coinGold),
                    ),
                  ],
                ),
            ],
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: i * 100)).slideX(begin: 0.2);
      },
    );
  }

  Widget _buildItemsTab() {
    final items = [
      _ItemData('補血包', Icons.favorite, AppColors.hpRed, 3, '回復 30 HP'),
      _ItemData('快速充電', Icons.bolt, AppColors.energyYellow, 5, '補滿電量'),
      _ItemData('攻擊強化', Icons.whatshot, Colors.orange, 1, '下回合 ATK x2'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: const Border.fromBorderSide(
              BorderSide(color: Color(0xFF1E3A5F)),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: item.color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      item.description,
                      style: const TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'x${item.count}',
                  style: TextStyle(
                    color: item.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: i * 100));
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(value, style: TextStyle(color: color, fontSize: 18, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _SkinData {
  final String name;
  final IconData icon;
  final Color color;
  final int coinPrice;

  _SkinData(this.name, this.icon, this.color, this.coinPrice);
}

class _WeaponData {
  final String name;
  final IconData icon;
  final int atk;
  final Color color;
  final bool isEquipped;
  final int? coinPrice;

  _WeaponData(this.name, this.icon, this.atk, this.color, this.isEquipped, [this.coinPrice]);
}

class _ItemData {
  final String name;
  final IconData icon;
  final Color color;
  final int count;
  final String description;

  _ItemData(this.name, this.icon, this.color, this.count, this.description);
}
