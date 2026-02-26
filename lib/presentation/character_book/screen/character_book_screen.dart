import 'package:emotion_defense/presentation/character_book/widgets/character_book_tab.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../widgets/synergy_book_tab.dart';

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
            '도감',
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
            tabs: const [
              Tab(text: '캐릭터'),
              Tab(text: '시너지'),
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
