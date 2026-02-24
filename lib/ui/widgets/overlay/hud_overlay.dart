import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/constants.dart';
import '../../../core/emotion_defense_game.dart';
import '../../../core/game_state.dart';
import '../../../gameplay/systems/synergy_system.dart';

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
              // 시너지 표시 바 (활성 시너지가 있을 때만)
              if (_hasActiveSynergy(synergy))
                Container(
                  width: double.infinity,
                  color: AppColor.hudBackground,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 2,
                    children: _buildSynergyChips(synergy),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  bool _hasActiveSynergy(SynergyBonuses s) {
    return s.allyAtkBonus > 0 ||
        s.allyAspdBonus > 0 ||
        s.enemySpeedPenalty > 0 ||
        s.enemyDefPenalty > 0 ||
        s.emotionExplosion ||
        s.dealerCritBonus > 0 ||
        s.stunDurationBonus > 0 ||
        s.bufferRangeBonus > 0 ||
        s.debufferDurationBonus > 0;
  }

  List<Widget> _buildSynergyChips(SynergyBonuses s) {
    final chips = <Widget>[];
    if (s.allyAtkBonus > 0) {
      chips.add(
        _SynergyChip(
          label: 'ATK+${(s.allyAtkBonus * 100).toInt()}%',
          color: AppColor.success,
        ),
      );
    }
    if (s.allyAspdBonus > 0) {
      chips.add(
        _SynergyChip(
          label: 'ASPD+${(s.allyAspdBonus * 100).toInt()}%',
          color: AppColor.success,
        ),
      );
    }
    if (s.enemySpeedPenalty > 0) {
      chips.add(
        _SynergyChip(
          label: '적속-${(s.enemySpeedPenalty * 100).toInt()}%',
          color: const Color(0xFF42A5F5),
        ),
      );
    }
    if (s.enemyDefPenalty > 0) {
      chips.add(
        _SynergyChip(
          label: '적방-${s.enemyDefPenalty.toInt()}',
          color: const Color(0xFF42A5F5),
        ),
      );
    }
    if (s.emotionExplosion) {
      chips.add(const _SynergyChip(label: '감정폭발', color: AppColor.danger));
    }
    if (s.dealerCritBonus > 0) {
      chips.add(
        _SynergyChip(
          label: '크리+${(s.dealerCritBonus * 100).toInt()}%',
          color: AppColor.warning,
        ),
      );
    }
    if (s.stunDurationBonus > 0) {
      chips.add(
        _SynergyChip(
          label: '스턴+${s.stunDurationBonus}s',
          color: const Color(0xFFAB47BC),
        ),
      );
    }
    if (s.bufferRangeBonus > 0) {
      chips.add(
        _SynergyChip(
          label: '범위+${s.bufferRangeBonus.toInt()}',
          color: const Color(0xFF00BCD4),
        ),
      );
    }
    if (s.debufferDurationBonus > 0) {
      chips.add(
        _SynergyChip(
          label: '디버프+${s.debufferDurationBonus}s',
          color: const Color(0xFF42A5F5),
        ),
      );
    }
    return chips;
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
        difficulty.label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SynergyChip extends StatelessWidget {
  final String label;
  final Color color;

  const _SynergyChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 0.8),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
