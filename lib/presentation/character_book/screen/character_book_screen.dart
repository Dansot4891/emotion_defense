import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:emotion_defense/presentation/character_book/widgets/character_book_tab.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../widgets/synergy/synergy_book_tab.dart';

/// 도감 화면 — 캐릭터 / 시너지 탭
class CharacterBookScreen extends StatelessWidget {
  const CharacterBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.surface,
          title: Text(
            LocaleKeys.bookTitle.tr(),
            style: AppTextStyle.hudLabel.copyWith(fontSize: 18),
          ),
          iconTheme: const IconThemeData(color: AppColor.textPrimary),
          bottom: TabBar(
            labelColor: AppColor.white,
            unselectedLabelColor: AppColor.textMuted,
            indicatorColor: AppColor.white,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: AppTextStyle.hudLabel.copyWith(fontSize: 14),
            unselectedLabelStyle: AppTextStyle.caption.copyWith(fontSize: 14),
            tabs: [
              Tab(text: LocaleKeys.bookCharacterTab.tr()),
              Tab(text: LocaleKeys.bookSynergyTab.tr()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 캐릭터 탭
            CharacterBookTab(),
            // 시너지 탭
            const SynergyBookTab(),
          ],
        ),
      ),
    );
  }
}
