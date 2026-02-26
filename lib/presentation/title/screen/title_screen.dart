import 'package:emotion_defense/app/route/routes.dart';
import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:emotion_defense/presentation/shared/button/app_small_button.dart';
import 'package:emotion_defense/presentation/title/widgets/title_difficult_item.dart';
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
            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppSmallButton(
                  text: '캐릭터 도감',
                  textStyle: AppTextStyle.buttonMedium,
                  onTap: () {
                    CharacterBookScreenRoute().push(context);
                  },
                ),
                AppSmallButton(
                  text: '시너지 도감',
                  textStyle: AppTextStyle.buttonMedium,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text("난이도", style: AppTextStyle.hudLabel),
            const SizedBox(height: 8),
            // 난이도 선택
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: Difficulty.values.map((d) {
                final selected = TitleScreen.selectedDifficulty == d;
                return TitleDifficultItem(
                  difficulty: d,
                  onTap: () => setState(() {
                    TitleScreen.selectedDifficulty = d;
                  }),
                  selected: selected,
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton.basePrimary(
                text: '게임 시작',
                textStyle: AppTextStyle.buttonLarge,
                onTap: () {
                  GameScreenRoute().go(context);
                },
              ),
            ),
            const SizedBox(height: 60),
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
