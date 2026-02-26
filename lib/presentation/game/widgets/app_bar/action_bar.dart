import 'package:emotion_defense/core/constants.dart';
import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../core/game_state.dart';

/// 하단 액션 버튼 바 - 뽑기, 조합, 강화, 판매
class ActionBar extends StatelessWidget {
  final EmotionDefenseGame game;

  const ActionBar({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final state = game.gameState;
        return SafeArea(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: GameConstants.actionBarHeight,
              padding: EdgeInsets.all(6),
              child: Row(
                spacing: 4,
                children: [
                  _textWithIconButton(
                    text: '뽑기 ${state.effectiveGachaCost}G',
                    icon: Icons.casino,
                    onTap: () => game.doGacha(),
                    enabled:
                        state.gold >= state.effectiveGachaCost &&
                        state.phase != GamePhase.gameOver &&
                        state.phase != GamePhase.victory,
                  ),
                  _textWithIconButton(
                    text: '조합',
                    icon: Icons.merge_type,
                    onTap: () => game.toggleCombinePopup(),
                    enabled:
                        state.phase == GamePhase.preparing ||
                        state.phase == GamePhase.waveActive,
                  ),
                  _textWithIconButton(
                    text: '강화',
                    icon: Icons.arrow_upward,
                    onTap: () => game.toggleUpgradePopup(),
                    enabled:
                        state.phase == GamePhase.preparing ||
                        state.phase == GamePhase.waveActive,
                  ),
                  _textWithIconButton(
                    text: game.isSellMode ? '판매중' : '판매',
                    icon: Icons.sell,
                    backgroundColor: game.isSellMode ? AppColor.danger : null,
                    onTap: () => game.toggleSellMode(),
                    enabled:
                        state.phase == GamePhase.preparing ||
                        state.phase == GamePhase.waveActive,
                  ),
                  _textWithIconButton(
                    text: '퀘스트',
                    icon: Icons.assignment,
                    onTap: () => game.toggleQuestPopup(),
                    enabled:
                        state.phase == GamePhase.preparing ||
                        state.phase == GamePhase.waveActive,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _textWithIconButton({
    required String text,
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
    Color? backgroundColor,
  }) {
    return AppButton.basePrimary(
      text: "",
      onTap: onTap,
      enabled: enabled,
      isExpanded: true,
      verticalPadding: 4,
      bgColor: backgroundColor ?? AppColor.primary,
      widget: Column(
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
              text,
              textAlign: TextAlign.center,
              style: AppTextStyle.buttonMedium.copyWith(
                color: enabled ? null : AppColor.textDisabled,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
