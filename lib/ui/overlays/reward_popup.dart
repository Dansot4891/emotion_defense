import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/emotion_defense_game.dart';
import '../../data/models/reward_model.dart';

/// 보상 선택 팝업 — 3개 카드 중 1개 선택
class RewardPopup extends StatelessWidget {
  final EmotionDefenseGame game;

  const RewardPopup({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final options = game.currentRewardOptions;
    if (options == null || options.isEmpty) return const SizedBox.shrink();

    return Container(
      color: const Color(0xAA000000),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Wave ${game.gameState.currentWave} 클리어!',
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 18,
                color: AppColor.gold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '보상을 선택하세요',
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 12,
                color: AppColor.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: options
                  .map((opt) => _RewardCard(
                        option: opt,
                        onTap: () => game.selectReward(opt),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _RewardCard extends StatelessWidget {
  final RewardOption option;
  final VoidCallback onTap;

  const _RewardCard({required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _typeColor(option.type), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_typeIcon(option.type), color: _typeColor(option.type),
                size: 28),
            const SizedBox(height: 6),
            Text(
              option.name,
              textAlign: TextAlign.center,
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 11,
                color: _typeColor(option.type),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              option.description,
              textAlign: TextAlign.center,
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 9,
                color: AppColor.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Color _typeColor(RewardType type) {
    switch (type) {
      case RewardType.bonusGold:
        return AppColor.gold;
      case RewardType.randomRare:
        return const Color(0xFF42A5F5);
      case RewardType.randomHero:
        return const Color(0xFFAB47BC);
      case RewardType.globalAtkBuff:
        return AppColor.danger;
      case RewardType.globalAspdBuff:
        return AppColor.success;
      case RewardType.gachaCostDiscount:
        return AppColor.warning;
      case RewardType.enemyLimitIncrease:
        return AppColor.textSecondary;
    }
  }

  static IconData _typeIcon(RewardType type) {
    switch (type) {
      case RewardType.bonusGold:
        return Icons.monetization_on;
      case RewardType.randomRare:
        return Icons.star;
      case RewardType.randomHero:
        return Icons.star_purple500;
      case RewardType.globalAtkBuff:
        return Icons.flash_on;
      case RewardType.globalAspdBuff:
        return Icons.speed;
      case RewardType.gachaCostDiscount:
        return Icons.discount;
      case RewardType.enemyLimitIncrease:
        return Icons.expand;
    }
  }
}
