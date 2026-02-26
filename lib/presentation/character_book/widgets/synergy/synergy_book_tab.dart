import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:emotion_defense/presentation/character_book/widgets/synergy/synergy_card.dart';
import 'package:emotion_defense/presentation/character_book/widgets/synergy/synergy_section.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../data/definitions/character_defs.dart';
import '../../../../data/models/character_model.dart';

/// 전체 캐릭터 리스트
final _allChars = [
  ...commonCharacters,
  ...rareCharacters,
  ...heroCharacters,
  ...legendCharacters,
];

/// 극성으로 캐릭터 이름 필터
List<CharacterData> _namesByPolarity(Polarity polarity) =>
    _allChars.where((c) => c.polarity == polarity).map((c) => c).toList()
      ..sort((a, b) => a.grade.index.compareTo(b.grade.index));

/// 역할로 캐릭터 이름 필터
List<CharacterData> _namesByRole(Role role) =>
    _allChars.where((c) => c.role == role).map((c) => c).toList()
      ..sort((a, b) => a.grade.index.compareTo(b.grade.index));

/// 시너지 도감 탭 — 극성/역할군 시너지 조건 + 효과 + 해당 캐릭터 표시
class SynergyBookTab extends StatelessWidget {
  const SynergyBookTab({super.key});

  @override
  Widget build(BuildContext context) {
    final positiveNames = _namesByPolarity(Polarity.positive);
    final negativeNames = _namesByPolarity(Polarity.negative);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SizedBox(height: 8),
        // 극성 시너지 섹션
        SynergySection(
          title: LocaleKeys.synergyPolaritySynergy.tr(),
          description: LocaleKeys.synergyPolaritySynergyDesc.tr(),
          entries: [
            SynergyEntry(
              label: LocaleKeys.synergyPositive3.tr(),
              condition: LocaleKeys.synergyPositive3Condition.tr(),
              effect: LocaleKeys.synergyPositive3Effect.tr(),
              color: AppColor.success,
              icon: Icons.sentiment_satisfied_alt,
              characters: positiveNames,
            ),
            SynergyEntry(
              label: LocaleKeys.synergyPositive5.tr(),
              condition: LocaleKeys.synergyPositive5Condition.tr(),
              effect: LocaleKeys.synergyPositive5Effect.tr(),
              color: AppColor.success,
              icon: Icons.sentiment_very_satisfied,
              characters: positiveNames,
            ),
            SynergyEntry(
              label: LocaleKeys.synergyNegative3.tr(),
              condition: LocaleKeys.synergyNegative3Condition.tr(),
              effect: LocaleKeys.synergyNegative3Effect.tr(),
              color: const Color(0xFF42A5F5),
              icon: Icons.sentiment_dissatisfied,
              characters: negativeNames,
            ),
            SynergyEntry(
              label: LocaleKeys.synergyNegative5.tr(),
              condition: LocaleKeys.synergyNegative5Condition.tr(),
              effect: LocaleKeys.synergyNegative5Effect.tr(),
              color: const Color(0xFF42A5F5),
              icon: Icons.sentiment_very_dissatisfied,
              characters: negativeNames,
            ),
            SynergyEntry(
              label: LocaleKeys.synergyEmotionExplosion.tr(),
              condition: LocaleKeys.synergyEmotionExplosionCondition.tr(),
              effect: LocaleKeys.synergyEmotionExplosionEffect.tr(),
              color: AppColor.danger,
              icon: Icons.local_fire_department,
              characters: [...positiveNames, ...negativeNames],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // 역할군 시너지 섹션
        SynergySection(
          title: LocaleKeys.synergyRoleSynergy.tr(),
          description: LocaleKeys.synergyRoleSynergyDesc.tr(),
          entries: [
            SynergyEntry(
              label: LocaleKeys.synergyDealer3.tr(),
              condition: LocaleKeys.synergyDealer3Condition.tr(),
              effect: LocaleKeys.synergyDealer3Effect.tr(),
              color: AppColor.warning,
              icon: Icons.bolt,
              characters: _namesByRole(Role.dealer),
            ),
            SynergyEntry(
              label: LocaleKeys.synergyStunner2.tr(),
              condition: LocaleKeys.synergyStunner2Condition.tr(),
              effect: LocaleKeys.synergyStunner2Effect.tr(),
              color: const Color(0xFFAB47BC),
              icon: Icons.pause_circle_filled,
              characters: _namesByRole(Role.stunner),
            ),
            SynergyEntry(
              label: LocaleKeys.synergyBuffer2.tr(),
              condition: LocaleKeys.synergyBuffer2Condition.tr(),
              effect: LocaleKeys.synergyBuffer2Effect.tr(),
              color: const Color(0xFF00BCD4),
              icon: Icons.shield,
              characters: _namesByRole(Role.buffer),
            ),
            SynergyEntry(
              label: LocaleKeys.synergyDebuffer2.tr(),
              condition: LocaleKeys.synergyDebuffer2Condition.tr(),
              effect: LocaleKeys.synergyDebuffer2Effect.tr(),
              color: const Color(0xFF42A5F5),
              icon: Icons.trending_down,
              characters: _namesByRole(Role.debuffer),
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
