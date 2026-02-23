import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/constants.dart';
import '../../core/emotion_defense_game.dart';

/// 상단 HUD 오버레이 - 웨이브 정보, 골드, leaked 수
class HudOverlay extends StatelessWidget {
  final EmotionDefenseGame game;

  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final state = game.gameState;
        return Container(
          height: GameConstants.hudHeight,
          color: AppColor.hudBackground,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SafeArea(
            bottom: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _HudItem(
                  icon: Icons.waves,
                  text: 'Wave ${state.currentWave}/${GameConstants.totalWaves}',
                ),
                _HudItem(
                  icon: Icons.monetization_on,
                  text: '${state.gold}G',
                  color: AppColor.gold,
                ),
                _HudItem(
                  icon: Icons.heart_broken,
                  text: '${state.enemiesLeaked}/${GameConstants.maxLeakedEnemies}',
                  color: state.enemiesLeaked > 15 ? AppColor.danger : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _HudItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? color;

  const _HudItem({required this.icon, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColor.textPrimary;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: c, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyle.hudLabel.copyWith(color: c),
        ),
      ],
    );
  }
}
