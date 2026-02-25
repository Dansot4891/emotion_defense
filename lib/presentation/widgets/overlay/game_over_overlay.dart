import 'package:emotion_defense/app/route/routes.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/emotion_defense_game.dart';
import '../../../core/game_state.dart';

/// 게임오버/승리 오버레이 화면 — 결과 통계 포함
class GameOverOverlay extends StatelessWidget {
  final EmotionDefenseGame game;

  const GameOverOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final isVictory = game.gameState.phase == GamePhase.victory;
    final accentColor = isVictory ? AppColor.borderGold : AppColor.borderDanger;
    final state = game.gameState;

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
              'Wave ${state.currentWave}까지 도달',
              style: AppTextStyle.gameOverSubtitle,
            ),
            const SizedBox(height: 16),
            // 통계
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _StatLine(
                    icon: Icons.pest_control,
                    label: '처치한 적',
                    value: '${state.totalEnemiesKilled}',
                  ),
                  const SizedBox(height: 6),
                  _StatLine(
                    icon: Icons.monetization_on,
                    label: '획득 골드',
                    value: '${state.totalGoldEarned}G',
                    color: AppColor.gold,
                  ),
                  const SizedBox(height: 6),
                  _StatLine(
                    icon: Icons.shopping_cart,
                    label: '소비 골드',
                    value: '${state.totalGoldSpent}G',
                  ),
                  const SizedBox(height: 6),
                  _StatLine(
                    icon: Icons.monetization_on,
                    label: '잔여 골드',
                    value: '${state.gold}G',
                    color: AppColor.gold,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
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
                  onPressed: () => TitleRoute().go(context),
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

class _StatLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? color;

  const _StatLine({
    required this.icon,
    required this.label,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColor.textSecondary;
    return Row(
      children: [
        Icon(icon, color: c, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyle.hudLabel.copyWith(
            fontSize: 12,
            color: AppColor.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyle.hudLabel.copyWith(fontSize: 12, color: c),
        ),
      ],
    );
  }
}
