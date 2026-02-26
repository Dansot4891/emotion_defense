import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:emotion_defense/data/definitions/character_defs.dart';
import 'package:emotion_defense/presentation/character_book/widgets/character_book_grade_section.dart';
import 'package:flutter/material.dart';
import '../../../data/models/character_model.dart';

/// 캐릭터 도감 탭 — 등급별 캐릭터 리스트
class CharacterBookTab extends StatelessWidget {
  const CharacterBookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        CharacterBookGradeSection(
          title: LocaleKeys.gradeCommon.tr(),
          grade: Grade.common,
          characters: commonCharacters,
        ),
        CharacterBookGradeSection(
          title: LocaleKeys.gradeRare.tr(),
          grade: Grade.rare,
          characters: rareCharacters,
        ),
        CharacterBookGradeSection(
          title: LocaleKeys.gradeHero.tr(),
          grade: Grade.hero,
          characters: heroCharacters,
        ),
        CharacterBookGradeSection(
          title: LocaleKeys.gradeLegend.tr(),
          grade: Grade.legend,
          characters: legendCharacters,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
