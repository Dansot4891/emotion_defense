import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:emotion_defense/app/route/routes.dart';
import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:emotion_defense/presentation/shared/button/app_small_button.dart';
import 'package:emotion_defense/presentation/title/widgets/title_difficult_item.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/game_state.dart';
import '../../../core/sound_manager.dart';

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
  void initState() {
    super.initState();
    SoundManager.instance.playBgm(Bgm.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(LocaleKeys.appName.tr(), style: AppTextStyle.title),
            const SizedBox(height: 48),
            AppSmallButton(
              text: LocaleKeys.titleCharacterBook.tr(),
              textStyle: AppTextStyle.buttonMedium,
              onTap: () {
                CharacterBookScreenRoute().push(context);
              },
            ),
            const SizedBox(height: 24),
            Text(LocaleKeys.titleDifficulty.tr(), style: AppTextStyle.hudLabel),
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
                text: LocaleKeys.titleStartGame.tr(),
                textStyle: AppTextStyle.buttonLarge,
                onTap: () {
                  GameScreenRoute().go(context);
                },
              ),
            ),
            const SizedBox(height: 60),
            Text(LocaleKeys.titleSubtitle.tr(), style: AppTextStyle.caption),
          ],
        ),
      ),
    );
  }
}
