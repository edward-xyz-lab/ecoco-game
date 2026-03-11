import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        title: const Text('商店'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: AppColors.coinGold, size: 18),
                const SizedBox(width: 4),
                const Text(
                  '250 幣',
                  style: TextStyle(color: AppColors.coinGold, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '幣包'),
            Tab(text: '道具'),
            Tab(text: 'VIP'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCoinPacksTab(),
          _buildItemsTab(),
          _buildVipTab(),
        ],
      ),
    );
  }

  Widget _buildCoinPacksTab() {
    final packs = [
      _CoinPack('小包', 60, 50, Icons.monetization_on, AppColors.coinGold),
      _CoinPack('中包', 160, 120, Icons.monetization_on, Colors.orange),
      _CoinPack('大包', 300, 200, Icons.monetization_on, Colors.deepOrange),
      _CoinPack('超值包', 680, 400, Icons.workspace_premium, Colors.purple),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: packs.length,
      itemBuilder: (_, i) {
        final pack = packs[i];
        return GestureDetector(
          onTap: () => _confirmPurchase(context, pack.name, pack.ntdPrice),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [pack.color.withOpacity(0.2), pack.color.withOpacity(0.05)],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: pack.color.withOpacity(0.4)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(pack.icon, color: pack.color, size: 40),
                const SizedBox(height: 8),
                Text(
                  pack.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.monetization_on, color: pack.color, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${pack.coins} 幣',
                      style: TextStyle(color: pack.color, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: pack.color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'NT\$ ${pack.ntdPrice}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: Duration(milliseconds: i * 100)),
        );
      },
    );
  }

  Widget _buildItemsTab() {
    final items = [
      _ShopItemData('補血包', Icons.favorite, AppColors.hpRed, '回復 30 HP', 3),
      _ShopItemData('快速充電', Icons.bolt, AppColors.energyYellow, '補滿電量', 5),
      _ShopItemData('攻擊強化', Icons.whatshot, Colors.orange, '下回合 ATK x2', 8),
      _ShopItemData('防禦護盾', Icons.shield, AppColors.secondary, '減少 50% 傷害 1回合', 10),
      _ShopItemData('幸運符', Icons.auto_awesome, Colors.pink, '爆擊率 +30%', 15),
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
              ElevatedButton(
                onPressed: () => _confirmPurchase(context, item.name, item.coinPrice, isCoin: true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.coinGold,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                child: Text('${item.coinPrice} 幣'),
              ),
            ],
          ),
        ).animate().fadeIn(delay: Duration(milliseconds: i * 80));
      },
    );
  }

  Widget _buildVipTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // VIP card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7B2FBE), Color(0xFFFF6B35)],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x887B2FBE),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.workspace_premium, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                const Text(
                  'VIP 月卡',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'NT\$ 99 / 月',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                const _VipBenefit('每日 20 ECOCO幣'),
                const _VipBenefit('打怪機率提高 50%'),
                const _VipBenefit('稀有服裝解鎖'),
                const _VipBenefit('戰鬥 VIP 特效'),
                const _VipBenefit('廣告跳過功能'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _confirmPurchase(context, 'VIP月卡', 99),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF7B2FBE),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    '立即訂閱',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ).animate().fadeIn().scale(begin: const Offset(0.95, 0.95)),
        ],
      ),
    );
  }

  void _confirmPurchase(BuildContext context, String name, int price, {bool isCoin = false}) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.cardDark,
        title: Text(
          '確認購買',
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          '購買 $name\n費用：${isCoin ? "$price 幣" : "NT\$ $price"}',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
            child: const Text('取消', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(dialogContext, rootNavigator: true).pop(),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('確認'),
          ),
        ],
      ),
    );
  }
}

class _VipBenefit extends StatelessWidget {
  final String text;
  const _VipBenefit(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }
}

class _CoinPack {
  final String name;
  final int ntdPrice;
  final int coins;
  final IconData icon;
  final Color color;

  _CoinPack(this.name, this.ntdPrice, this.coins, this.icon, this.color);
}

class _ShopItemData {
  final String name;
  final IconData icon;
  final Color color;
  final String description;
  final int coinPrice;

  _ShopItemData(this.name, this.icon, this.color, this.description, this.coinPrice);
}
