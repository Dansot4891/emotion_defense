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
          title: '극성 시너지',
          description: '같은 극성의 캐릭터를 일정 수 이상 배치하면 발동',
          entries: [
            SynergyEntry(
              label: '긍정 3+',
              condition: '긍정 극성 캐릭터 3명 이상 배치',
              effect: '아군 전체 ATK +10%',
              color: AppColor.success,
              icon: Icons.sentiment_satisfied_alt,
              characters: positiveNames,
            ),
            SynergyEntry(
              label: '긍정 5+',
              condition: '긍정 극성 캐릭터 5명 이상 배치',
              effect: '아군 전체 ATK +20%, ASPD +10%',
              color: AppColor.success,
              icon: Icons.sentiment_very_satisfied,
              characters: positiveNames,
            ),
            SynergyEntry(
              label: '부정 3+',
              condition: '부정 극성 캐릭터 3명 이상 배치',
              effect: '적 이동속도 -10%',
              color: const Color(0xFF42A5F5),
              icon: Icons.sentiment_dissatisfied,
              characters: negativeNames,
            ),
            SynergyEntry(
              label: '부정 5+',
              condition: '부정 극성 캐릭터 5명 이상 배치',
              effect: '적 이동속도 -20%, 적 방어력 -2',
              color: const Color(0xFF42A5F5),
              icon: Icons.sentiment_very_dissatisfied,
              characters: negativeNames,
            ),
            SynergyEntry(
              label: '감정폭발',
              condition: '긍정 3+ & 부정 3+ 동시 달성',
              effect: '5웨이브마다 전체 적에게 100 데미지',
              color: AppColor.danger,
              icon: Icons.local_fire_department,
              characters: [...positiveNames, ...negativeNames],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // 역할군 시너지 섹션
        SynergySection(
          title: '역할군 시너지',
          description: '같은 역할의 캐릭터를 일정 수 이상 배치하면 발동',
          entries: [
            SynergyEntry(
              label: '딜러 3+',
              condition: '딜러 역할 캐릭터 3명 이상 배치',
              effect: '딜러 크리티컬 확률 +15%',
              color: AppColor.warning,
              icon: Icons.bolt,
              characters: _namesByRole(Role.dealer),
            ),
            SynergyEntry(
              label: '스터너 2+',
              condition: '스터너 역할 캐릭터 2명 이상 배치',
              effect: '스턴 지속시간 +0.5초',
              color: const Color(0xFFAB47BC),
              icon: Icons.pause_circle_filled,
              characters: _namesByRole(Role.stunner),
            ),
            SynergyEntry(
              label: '버퍼 2+',
              condition: '버퍼 역할 캐릭터 2명 이상 배치',
              effect: '오라 범위 +1칸',
              color: const Color(0xFF00BCD4),
              icon: Icons.shield,
              characters: _namesByRole(Role.buffer),
            ),
            SynergyEntry(
              label: '디버퍼 2+',
              condition: '디버퍼 역할 캐릭터 2명 이상 배치',
              effect: '디버프 지속시간 +1.0초',
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
