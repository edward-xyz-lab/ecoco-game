import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/battle_model.dart';
import '../../providers/game_provider.dart';
import '../../widgets/common/stat_bar.dart';

class BattleScreen extends ConsumerStatefulWidget {
  final String monsterId;
  final String stationId;

  const BattleScreen({super.key, required this.monsterId, required this.stationId});

  @override
  ConsumerState<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends ConsumerState<BattleScreen>
    with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late AnimationController _flashController;
  bool _playerAttacking = false;
  bool _monsterAttacking = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _flashController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(battleNotifierProvider.notifier).startBattle(
            widget.monsterId,
            widget.stationId,
          );
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _flashController.dispose();
    super.dispose();
  }

  Future<void> _attack() async {
    setState(() => _playerAttacking = true);
    await Future.delayed(const Duration(milliseconds: 150));
    await ref.read(battleNotifierProvider.notifier).attack();
    _shakeController.forward(from: 0);
    setState(() => _playerAttacking = false);

    final state = ref.read(battleNotifierProvider);
    if (state?.status == BattleStatus.victory) {
      await Future.delayed(const Duration(milliseconds: 500));
      _showResultDialog(true, state!.rewards ?? []);
    } else if (state?.status == BattleStatus.defeat) {
      await Future.delayed(const Duration(milliseconds: 500));
      _showResultDialog(false, []);
    }
  }

  void _flee() {
    ref.read(battleNotifierProvider.notifier).flee();
    context.pop();
  }

  void _showResultDialog(bool won, List<RewardSummary> rewards) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => BattleResultDialog(
        won: won,
        rewards: rewards,
        onContinue: () {
          ref.read(battleNotifierProvider.notifier).reset();
          Navigator.of(context).pop(); // close dialog
          context.pop(); // back to map
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final battleState = ref.watch(battleNotifierProvider);

    if (battleState == null) {
      return const Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Center(child: CircularProgressIndicator(color: AppColors.primary)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // Background
          _buildBackground(),

          SafeArea(
            child: Column(
              children: [
                // Top bar
                _buildTopBar(context),
                const SizedBox(height: 16),

                // Monster section
                Expanded(
                  flex: 3,
                  child: _buildMonsterSection(battleState),
                ),

                // Battle log
                Expanded(
                  flex: 2,
                  child: _buildBattleLog(battleState),
                ),

                // Player section
                _buildPlayerSection(battleState),

                // Action bar
                _buildActionBar(battleState),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 1.5,
          colors: [Color(0xFF0D2137), AppColors.darkBg],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white54),
            onPressed: _flee,
          ),
          const Spacer(),
          const Text(
            '⚔ 戰鬥中',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildMonsterSection(BattleState battleState) {
    final hpRatio = battleState.monsterHp / battleState.monsterMaxHp;

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (_, child) {
        final shakeX = sin(_shakeController.value * pi * 6) * 8;
        return Transform.translate(
          offset: Offset(shakeX, 0),
          child: child,
        );
      },
      child: Column(
        children: [
          // Monster HP bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '電池怪',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${battleState.monsterHp} / ${battleState.monsterMaxHp}',
                      style: const TextStyle(color: AppColors.hpRed, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: hpRatio,
                    backgroundColor: AppColors.hpRed.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(
                      hpRatio > 0.5
                          ? AppColors.hpRed
                          : hpRatio > 0.2
                              ? Colors.orange
                              : Colors.red,
                    ),
                    minHeight: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Monster sprite
          Expanded(
            child: Center(
              child: _MonsterSprite(
                isAttacking: _monsterAttacking,
                hp: battleState.monsterHp,
                maxHp: battleState.monsterMaxHp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBattleLog(BattleState battleState) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardDark.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: const Border.fromBorderSide(BorderSide(color: Color(0xFF1E3A5F))),
      ),
      child: battleState.logs.isEmpty
          ? const Center(
              child: Text(
                '戰鬥開始！',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
            )
          : ListView.builder(
              reverse: true,
              itemCount: battleState.logs.length.clamp(0, 6),
              itemBuilder: (_, i) {
                final log = battleState.logs.reversed.toList()[i];
                final isPlayer = log.actorId == 'player';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    isPlayer
                        ? '⚡ 你攻擊造成 ${log.damage} 傷害'
                        : '💥 怪物反擊造成 ${log.damage} 傷害',
                    style: TextStyle(
                      color: isPlayer ? AppColors.primary : AppColors.hpRed,
                      fontSize: 13,
                    ),
                  ).animate().fadeIn(duration: 200.ms),
                );
              },
            ),
    );
  }

  Widget _buildPlayerSection(BattleState battleState) {
    final hpRatio = battleState.playerHp / battleState.playerMaxHp;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(BorderSide(color: Color(0xFF1E3A5F))),
      ),
      child: Row(
        children: [
          // Player avatar
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 52,
            height: 52,
            transform: _playerAttacking
                ? Matrix4.translationValues(8, 0, 0)
                : Matrix4.identity(),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2),
              gradient: const LinearGradient(
                colors: [AppColors.primaryDark, AppColors.primary],
              ),
            ),
            child: const Icon(Icons.bolt, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '小電精',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${battleState.playerHp} / ${battleState.playerMaxHp}',
                      style: const TextStyle(color: AppColors.hpRed, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                StatBar(
                  label: 'HP',
                  value: battleState.playerHp,
                  max: battleState.playerMaxHp,
                  color: hpRatio > 0.3 ? AppColors.hpRed : Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(BattleState battleState) {
    final inBattle = battleState.status == BattleStatus.inProgress;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: inBattle ? _flee : null,
              icon: const Icon(Icons.directions_run, size: 18),
              label: const Text('逃跑'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white54,
                side: const BorderSide(color: Colors.white24),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: inBattle ? _attack : null,
              icon: const Icon(Icons.flash_on, size: 20),
              label: Text(
                inBattle ? '攻擊！' : battleState.status.name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shadowColor: AppColors.primary.withOpacity(0.5),
                elevation: 8,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: inBattle ? () {} : null,
              icon: const Icon(Icons.backpack, size: 18),
              label: const Text('道具'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.accent,
                side: BorderSide(color: AppColors.accent.withOpacity(0.5)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Monster Sprite ─────────────────────────────────────────────────────────────

class _MonsterSprite extends StatelessWidget {
  final bool isAttacking;
  final int hp;
  final int maxHp;

  const _MonsterSprite({
    required this.isAttacking,
    required this.hp,
    required this.maxHp,
  });

  @override
  Widget build(BuildContext context) {
    final isDead = hp <= 0;
    final hpRatio = hp / maxHp;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.hpRed.withOpacity(0.1),
            border: Border.all(
              color: hpRatio > 0.5
                  ? AppColors.hpRed.withOpacity(0.5)
                  : Colors.red.withOpacity(0.8),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.hpRed.withOpacity(hpRatio * 0.4),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: isDead
              ? const Icon(Icons.close, color: Colors.red, size: 60)
              : Icon(
                  Icons.battery_alert,
                  color: Colors.red.withOpacity(0.8 + hpRatio * 0.2),
                  size: 70,
                )
                    .animate(onPlay: (c) => c.repeat())
                    .scale(
                      begin: const Offset(1, 1),
                      end: const Offset(1.05, 1.05),
                      duration: 1200.ms,
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.05, 1.05),
                      end: const Offset(1, 1),
                      duration: 1200.ms,
                    ),
        ),
        if (isDead)
          const Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              '💀 擊敗！',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

// ── Battle Result Dialog ───────────────────────────────────────────────────────

class BattleResultDialog extends StatelessWidget {
  final bool won;
  final List<RewardSummary> rewards;
  final VoidCallback onContinue;

  const BattleResultDialog({
    super.key,
    required this.won,
    required this.rewards,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: won ? AppColors.primary : AppColors.hpRed,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (won ? AppColors.primary : AppColors.hpRed).withOpacity(0.3),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              won ? '🎉 勝利！' : '💀 敗北...',
              style: TextStyle(
                color: won ? AppColors.primary : AppColors.hpRed,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ).animate().scale(duration: 400.ms, curve: Curves.bounceOut),
            const SizedBox(height: 20),
            if (won && rewards.isNotEmpty) ...[
              const Text(
                '獲得獎勵',
                style: TextStyle(color: Colors.white54, fontSize: 14),
              ),
              const SizedBox(height: 12),
              ...rewards.map(
                (r) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        r.type == 'coins' ? Icons.monetization_on : Icons.eco,
                        color: r.type == 'coins' ? AppColors.coinGold : AppColors.pointsGreen,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '+${r.amount} ${r.label}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.2),
                ),
              ),
            ] else if (!won) ...[
              const Text(
                '角色需要補充HP\n到補充站補血，或用ECOCO幣回復',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white54, height: 1.6),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: won ? AppColors.primary : AppColors.surfaceDark,
                minimumSize: const Size(double.infinity, 48),
              ),
              child: Text(won ? '繼續探索' : '返回地圖'),
            ),
          ],
        ),
      ),
    );
  }
}
