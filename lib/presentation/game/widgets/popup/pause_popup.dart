import 'package:emotion_defense/app/route/routes.dart';
import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';

/// 일시정지 오버레이 — 반투명 배경 + 계속하기/타이틀 버튼
class PausePopup extends StatelessWidget {
  final EmotionDefenseGame game;

  const PausePopup({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 240,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColor.overlay,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.primary, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '일시정지',
                style: AppTextStyle.gameOverTitle.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 32),
              AppButton.basePrimary(
                text: '계속하기',
                textStyle: AppTextStyle.hudLabel,
                onTap: () => game.togglePause(),
              ),
              const SizedBox(height: 12),
              AppButton.basePrimary(
                text: '타이틀로',
                bgColor: AppColor.danger,
                textStyle: AppTextStyle.hudLabel,
                onTap: () {
                  game.togglePause();
                  TitleRoute().go(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
