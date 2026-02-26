import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:flutter/material.dart';
import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../data/models/character_model.dart';

/// 캐릭터 카드 — 이미지 + 이름/역할/스탯/스킬
class CharacterBookCharacterCard extends StatelessWidget {
  final CharacterData data;

  const CharacterBookCharacterCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: data.grade.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 캐릭터 이미지
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: data.grade.color.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Image.asset(data.imagePath, fit: BoxFit.contain),
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
                      data.name.tr(),
                      style: AppTextStyle.hudLabel.copyWith(
                        fontSize: 15,
                        color: data.grade.color,
                      ),
                    ),
                    const SizedBox(width: 6),
                    _Tag(
                      label: data.polarity.displayName.tr(),
                      color: data.polarity.color,
                    ),
                    const SizedBox(width: 4),
                    _Tag(
                      label: data.role.displayName.tr(),
                      color: AppColor.textSecondary,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // 설명
                Text(
                  data.description.tr(),
                  style: AppTextStyle.caption.copyWith(
                    fontSize: 14,
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
                      label: LocaleKeys.characterInfoPassive.tr(),
                      description: p.description.tr(),
                      color: AppColor.success,
                    ),
                  ),
                  ...data.actives.map(
                    (a) => _SkillLine(
                      label: LocaleKeys.characterInfoActive.tr(),
                      description: a.description.tr(),
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
          fontSize: 12,
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
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 12,
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
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: AppColor.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
