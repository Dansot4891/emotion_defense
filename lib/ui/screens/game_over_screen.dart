import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/emotion_defense_game.dart';
import '../../core/game_state.dart';

/// 게임오버/승리 오버레이 화면
class GameOverOverlay extends StatelessWidget {
  final EmotionDefenseGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final isVictory = game.gameState.phase == GamePhase.victory;
    final accentColor = isVictory ? AppColor.borderGold : AppColor.borderDanger;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColor.overlay,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: accentColor, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isVictory
                  ? Icons.emoji_events
                  : Icons.sentiment_very_dissatisfied,
              color: accentColor,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              isVictory ? '승리!' : '게임오버',
              style: AppTextStyle.gameOverTitle.copyWith(color: accentColor),
            ),
            const SizedBox(height: 8),
            Text(
              'Wave ${game.gameState.currentWave}까지 도달',
              style: AppTextStyle.gameOverSubtitle,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () => game.resetGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('다시 시작'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.disabled,
                    foregroundColor: AppColor.textPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('타이틀로'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
