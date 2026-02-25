import 'package:emotion_defense/app/route/routes.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/game_state.dart';

/// 타이틀 화면 - "감정디펜스" + 난이도 선택 + 시작 버튼
class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  /// 선택된 난이도 (GameScreen에서 참조)
  static Difficulty selectedDifficulty = Difficulty.normal;

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
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
            TextButton(
              onPressed: () {
                CharacterBookScreenRoute().push(context);
              },
              child: const Text('캐릭터 도감', style: AppTextStyle.subtitle),
            ),
            const SizedBox(height: 16),
            // 난이도 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Difficulty.values.map((d) {
                final selected = TitleScreen.selectedDifficulty == d;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: GestureDetector(
                    onTap: () => setState(() {
                      TitleScreen.selectedDifficulty = d;
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? _difficultyColor(d).withValues(alpha: 0.25)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selected
                              ? _difficultyColor(d)
                              : AppColor.textMuted,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        d.label,
                        style: TextStyle(
                          color: selected
                              ? _difficultyColor(d)
                              : AppColor.textSecondary,
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
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

  static Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return AppColor.success;
      case Difficulty.normal:
        return AppColor.primary;
      case Difficulty.hard:
        return AppColor.warning;
      case Difficulty.hell:
        return AppColor.danger;
    }
  }
}
