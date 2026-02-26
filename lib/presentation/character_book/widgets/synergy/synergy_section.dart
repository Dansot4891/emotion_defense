import 'package:emotion_defense/presentation/character_book/widgets/synergy/synergy_card.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';

/// 시너지 섹션 — 제목 + 설명 + 시너지 카드 리스트
class SynergySection extends StatelessWidget {
  final String title;
  final String description;
  final List<SynergyEntry> entries;

  const SynergySection({
    super.key,
    required this.title,
    required this.description,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 섹션 헤더
        Row(
          children: [
            Container(
              width: 4,
              height: 20,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTextStyle.hudLabel.copyWith(color: AppColor.white),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyle.caption.copyWith(color: AppColor.white),
        ),
        const SizedBox(height: 10),
        // 시너지 카드 리스트
        ...entries.map((e) => SynergyCard(entry: e)),
      ],
    );
  }
}
