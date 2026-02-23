import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/constants.dart';
import '../../core/emotion_defense_game.dart';
import '../../core/game_state.dart';

/// 하단 액션 버튼 바 - 뽑기, 웨이브 시작, 조합(비활성), 판매(비활성)
class ActionBar extends StatelessWidget {
  final EmotionDefenseGame game;

  const ActionBar({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final state = game.gameState;
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: GameConstants.actionBarHeight,
            color: AppColor.hudBackground,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  label: '뽑기\n${GameConstants.gachaCost}G',
                  icon: Icons.casino,
                  enabled: state.gold >= GameConstants.gachaCost &&
                      state.phase != GamePhase.gameOver &&
                      state.phase != GamePhase.victory,
                  onTap: () => game.doGacha(),
                ),
                _ActionButton(
                  label: state.phase == GamePhase.waveActive
                      ? '진행중...'
                      : '웨이브\n시작',
                  icon: Icons.play_arrow,
                  enabled: state.phase == GamePhase.preparing,
                  onTap: () => game.startWave(),
                ),
                const _ActionButton(
                  label: '조합',
                  icon: Icons.merge_type,
                  enabled: false,
                  onTap: null,
                ),
                const _ActionButton(
                  label: '판매',
                  icon: Icons.sell,
                  enabled: false,
                  onTap: null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: enabled ? AppColor.primary : AppColor.disabled,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: enabled ? AppColor.textPrimary : AppColor.textDisabled,
              size: 18,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: enabled
                  ? AppTextStyle.buttonSmall
                  : AppTextStyle.buttonSmallDisabled,
            ),
          ],
        ),
      ),
    );
  }
}
