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
        return SafeArea(
          bottom: false,
          child: Container(
            height: GameConstants.hudHeight,
            color: AppColor.hudBackground,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                _HudItem(
                  icon: Icons.waves,
                  text: 'Wave ${state.currentWave}/${GameConstants.totalWaves}',
                ),
                const SizedBox(width: 12),
                _HudItem(
                  icon: Icons.monetization_on,
                  text: '${state.gold}G',
                  color: AppColor.gold,
                ),
                const SizedBox(width: 12),
                _HudItem(
                  icon: Icons.pest_control,
                  text: '${state.enemiesAlive}/${state.effectiveMaxAliveEnemies}',
                  color: state.enemiesAlive > state.effectiveMaxAliveEnemies - 5
                      ? AppColor.danger
                      : null,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => game.togglePause(),
                  child: const Icon(
                    Icons.pause,
                    color: AppColor.textPrimary,
                    size: 24,
                  ),
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
