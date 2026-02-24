import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/emotion_defense_game.dart';
import '../../../core/game_state.dart';

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
        final bottomPadding = MediaQuery.of(context).padding.bottom;
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: AppColor.hudBackground,
            padding: EdgeInsets.only(
              left: 6,
              right: 6,
              top: 6,
              bottom: 6 + bottomPadding,
            ),
            child: Row(
              children: [
                _ActionButton(
                  label: '뽑기\n${state.effectiveGachaCost}G',
                  icon: Icons.casino,
                  enabled:
                      state.gold >= state.effectiveGachaCost &&
                      state.phase != GamePhase.gameOver &&
                      state.phase != GamePhase.victory,
                  onTap: () => game.doGacha(),
                ),
                const SizedBox(width: 4),
                _ActionButton(
                  label: state.phase == GamePhase.waveActive
                      ? '진행중...'
                      : '다음\n${game.autoWaveRemaining.ceil()}s',
                  icon: state.phase == GamePhase.waveActive
                      ? Icons.play_arrow
                      : Icons.timer,
                  enabled: state.phase == GamePhase.preparing,
                  onTap: () => game.startWave(),
                ),
                const SizedBox(width: 4),
                _ActionButton(
                  label: '조합',
                  icon: Icons.merge_type,
                  enabled:
                      state.phase == GamePhase.preparing ||
                      state.phase == GamePhase.waveActive,
                  onTap: () => game.toggleCombinePopup(),
                ),
                const SizedBox(width: 4),
                _ActionButton(
                  label: '강화',
                  icon: Icons.arrow_upward,
                  enabled:
                      state.phase == GamePhase.preparing ||
                      state.phase == GamePhase.waveActive,
                  onTap: () => game.toggleUpgradePopup(),
                ),
                const SizedBox(width: 4),
                _ActionButton(
                  label: game.isSellMode ? '판매중' : '판매',
                  icon: Icons.sell,
                  enabled:
                      state.phase == GamePhase.preparing ||
                      state.phase == GamePhase.waveActive,
                  highlight: game.isSellMode,
                  onTap: () => game.toggleSellMode(),
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
  final bool highlight;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = highlight
        ? AppColor.danger
        : enabled
        ? AppColor.primary
        : AppColor.disabled;
    return Expanded(
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: bgColor,
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
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: enabled
                      ? AppTextStyle.buttonSmall
                      : AppTextStyle.buttonSmallDisabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
