import 'package:emotion_defense/ui/screens/title_screen.dart';
import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/emotion_defense_game.dart';

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
              _PauseButton(
                label: '계속하기',
                color: AppColor.primary,
                onTap: () => game.togglePause(),
              ),
              const SizedBox(height: 12),
              _PauseButton(
                label: '타이틀로',
                color: AppColor.danger,
                onTap: () {
                  game.togglePause();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const TitleScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PauseButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _PauseButton({
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyle.hudLabel,
        ),
      ),
    );
  }
}
