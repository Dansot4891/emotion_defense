import 'package:emotion_defense/app/route/routes.dart';
import 'package:flutter/material.dart';
import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';

/// 타이틀 화면 - "감정디펜스" + 시작 버튼
class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('감정디펜스', style: AppTextStyle.title),
            const SizedBox(height: 8),
            const Text('Emotion Defense', style: AppTextStyle.subtitle),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                GameScreenRoute().go(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                foregroundColor: AppColor.textPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('게임 시작', style: AppTextStyle.buttonLarge),
            ),
            const SizedBox(height: 80),
            const Text(
              'Random Combination Tower Defense',
              style: AppTextStyle.caption,
            ),
          ],
        ),
      ),
    );
  }
}
