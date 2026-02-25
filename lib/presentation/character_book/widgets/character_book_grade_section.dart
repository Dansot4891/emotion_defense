import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../data/models/character_model.dart';
import 'character_book_character_card.dart';
import 'character_book_utils.dart';

/// 등급별 섹션 — 헤더 + 캐릭터 카드 리스트
class CharacterBookGradeSection extends StatelessWidget {
  final String title;
  final Grade grade;
  final List<CharacterData> characters;

  const CharacterBookGradeSection({
    super.key,
    required this.title,
    required this.grade,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final color = gradeColor(grade);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        // 등급 헤더
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$title 등급',
              style: AppTextStyle.hudLabel.copyWith(color: color),
            ),
            const SizedBox(width: 8),
            Text(
              '${characters.length}종',
              style: AppTextStyle.hudLabel.copyWith(color: AppColor.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 캐릭터 카드 리스트
        ...characters.map((c) => CharacterBookCharacterCard(data: c)),
      ],
    );
  }
}
