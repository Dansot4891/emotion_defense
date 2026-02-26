import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/constants.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../core/game_state.dart';

/// 상단 HUD 오버레이 - 웨이브 정보, 골드, 적 수, 시너지, 배속, 일시정지
class HudOverlay extends StatelessWidget {
  final EmotionDefenseGame game;

  const HudOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final state = game.gameState;
        final synergy = game.synergyBonuses;
        return SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 메인 HUD 바
              Container(
                height: GameConstants.hudHeight,
                color: AppColor.hudBackground,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    _HudItem(
                      icon: Icons.waves,
                      text: 'W${state.currentWave}/${GameConstants.totalWaves}',
                    ),
                    const SizedBox(width: 6),
                    _DifficultyChip(difficulty: state.difficulty),
                    const SizedBox(width: 10),
                    _HudItem(
                      icon: Icons.monetization_on,
                      text: '${state.gold}G',
                      color: AppColor.gold,
                    ),
                    const SizedBox(width: 10),
                    _HudItem(
                      icon: Icons.pest_control,
                      text:
                          '${state.enemiesAlive}/${state.effectiveMaxAliveEnemies}',
                      color:
                          state.enemiesAlive >
                              state.effectiveMaxAliveEnemies - 5
                          ? AppColor.danger
                          : null,
                    ),
                    const SizedBox(width: 10),
                    // 시너지 버튼
                    _SynergyButton(
                      count: synergy.activeCount,
                      onTap: () => game.toggleSynergyPopup(),
                    ),
                    const Spacer(),
                    // 배속 버튼
                    GestureDetector(
                      onTap: () => game.toggleSpeed(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: game.gameSpeed > 1
                                ? AppColor.warning
                                : AppColor.textMuted,
                          ),
                        ),
                        child: Text(
                          'x${game.gameSpeed}',
                          style: AppTextStyle.hudLabel.copyWith(
                            fontSize: 11,
                            color: game.gameSpeed > 1
                                ? AppColor.warning
                                : AppColor.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // 일시정지
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
            ],
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
        Text(text, style: AppTextStyle.hudLabel.copyWith(color: c)),
      ],
    );
  }
}

class _DifficultyChip extends StatelessWidget {
  final Difficulty difficulty;

  const _DifficultyChip({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    if (difficulty == Difficulty.normal) return const SizedBox.shrink();
    final color = switch (difficulty) {
      Difficulty.easy => AppColor.success,
      Difficulty.normal => AppColor.primary,
      Difficulty.hard => AppColor.warning,
      Difficulty.hell => AppColor.danger,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        difficulty.label.tr(),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// 시너지 버튼 — 활성 시너지 개수 표시, 탭하면 시너지 팝업 열기
class _SynergyButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const _SynergyButton({required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    final active = count > 0;
    final color = active ? AppColor.primary : AppColor.textMuted;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color),
          color: active ? color.withValues(alpha: 0.15) : Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, color: color, size: 13),
            const SizedBox(width: 3),
            Text(
              LocaleKeys.gameSynergyCount.tr(namedArgs: {'count': '$count'}),
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
