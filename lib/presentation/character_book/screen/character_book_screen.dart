import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../data/definitions/character_defs.dart';
import '../../../data/models/character_model.dart';
import '../widgets/character_book_grade_section.dart';

/// 캐릭터 도감 화면 — 등급별 캐릭터 리스트 + 상세 정보
class CharacterBookScreen extends StatelessWidget {
  const CharacterBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.surface,
        title: Text(
          '캐릭터 도감',
          style: AppTextStyle.hudLabel.copyWith(fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: AppColor.textPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          CharacterBookGradeSection(
            title: '일반',
            grade: Grade.common,
            characters: commonCharacters,
          ),
          CharacterBookGradeSection(
            title: '레어',
            grade: Grade.rare,
            characters: rareCharacters,
          ),
          CharacterBookGradeSection(
            title: '영웅',
            grade: Grade.hero,
            characters: heroCharacters,
          ),
          CharacterBookGradeSection(
            title: '전설',
            grade: Grade.legend,
            characters: legendCharacters,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
