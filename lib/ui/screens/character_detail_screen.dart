import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../data/definitions/character_defs.dart';
import '../../data/models/character_model.dart';

/// 캐릭터 도감 화면 — 등급별 캐릭터 리스트 + 상세 정보
class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

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
          _GradeSection(
            title: '일반',
            grade: Grade.common,
            characters: commonCharacters,
          ),
          _GradeSection(
            title: '레어',
            grade: Grade.rare,
            characters: rareCharacters,
          ),
          _GradeSection(
            title: '영웅',
            grade: Grade.hero,
            characters: heroCharacters,
          ),
          _GradeSection(
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

/// 등급별 섹션 — 헤더 + 캐릭터 카드 리스트
class _GradeSection extends StatelessWidget {
  final String title;
  final Grade grade;
  final List<CharacterData> characters;

  const _GradeSection({
    required this.title,
    required this.grade,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final color = _gradeColor(grade);

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
              style: AppTextStyle.hudLabel.copyWith(fontSize: 16, color: color),
            ),
            const SizedBox(width: 8),
            Text(
              '${characters.length}종',
              style: AppTextStyle.caption.copyWith(color: AppColor.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 캐릭터 카드 리스트
        ...characters.map((c) => _CharacterCard(data: c)),
      ],
    );
  }
}

/// 캐릭터 카드 — 이미지 + 이름/역할/스탯/스킬
class _CharacterCard extends StatelessWidget {
  final CharacterData data;

  const _CharacterCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final gradeColor = _gradeColor(data.grade);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: gradeColor.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 캐릭터 이미지
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: gradeColor.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.asset(data.imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          // 정보 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 이름 + 태그들
                Row(
                  children: [
                    Text(
                      data.name,
                      style: AppTextStyle.hudLabel.copyWith(
                        fontSize: 15,
                        color: gradeColor,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _Tag(
                      label: _polarityName(data.polarity),
                      color: _polarityColor(data.polarity),
                    ),
                    const SizedBox(width: 4),
                    _Tag(
                      label: _roleName(data.role),
                      color: AppColor.textSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 설명
                Text(
                  data.description,
                  style: AppTextStyle.caption.copyWith(
                    fontSize: 11,
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                // 스탯
                Row(
                  children: [
                    _StatChip(label: 'ATK', value: '${data.atk.toInt()}'),
                    const SizedBox(width: 8),
                    _StatChip(label: 'ASPD', value: '${data.aspd}s'),
                    const SizedBox(width: 8),
                    _StatChip(label: 'RNG', value: '${data.range}'),
                  ],
                ),
                // 스킬 목록
                if (data.passives.isNotEmpty || data.actives.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  ...data.passives.map(
                    (p) => _SkillLine(
                      label: '패시브',
                      description: p.description,
                      color: AppColor.success,
                    ),
                  ),
                  ...data.actives.map(
                    (a) => _SkillLine(
                      label: '액티브',
                      description: a.description,
                      color: AppColor.warning,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 작은 태그 (극성/역할 표시)
class _Tag extends StatelessWidget {
  final String label;
  final Color color;

  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: color.withValues(alpha: 0.5), width: 0.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// 스탯 칩 (ATK / ASPD / RNG)
class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            color: AppColor.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// 스킬 한 줄
class _SkillLine extends StatelessWidget {
  final String label;
  final String description;
  final Color color;

  const _SkillLine({
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: TextStyle(
              color: color,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: AppColor.textSecondary,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// === 유틸 함수 ===

Color _gradeColor(Grade grade) {
  switch (grade) {
    case Grade.common:
      return AppColor.gradeCommon;
    case Grade.rare:
      return AppColor.gradeRare;
    case Grade.hero:
      return AppColor.gradeHero;
    case Grade.legend:
      return AppColor.gradeLegend;
  }
}

String _polarityName(Polarity p) {
  switch (p) {
    case Polarity.positive:
      return '긍정';
    case Polarity.negative:
      return '부정';
    case Polarity.neutral:
      return '중립';
  }
}

Color _polarityColor(Polarity p) {
  switch (p) {
    case Polarity.positive:
      return AppColor.success;
    case Polarity.negative:
      return AppColor.danger;
    case Polarity.neutral:
      return AppColor.warning;
  }
}

String _roleName(Role r) {
  switch (r) {
    case Role.dealer:
      return '딜러';
    case Role.stunner:
      return '스터너';
    case Role.buffer:
      return '버퍼';
    case Role.debuffer:
      return '디버퍼';
  }
}
