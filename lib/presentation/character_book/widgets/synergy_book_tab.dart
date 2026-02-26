import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';

/// 시너지 도감 탭 — 극성/역할군 시너지 조건 + 효과 정적 표시
class SynergyBookTab extends StatelessWidget {
  const SynergyBookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      children: [
        const SizedBox(height: 8),
        // 극성 시너지 섹션
        _SynergySection(
          title: '극성 시너지',
          description: '같은 극성의 캐릭터를 일정 수 이상 배치하면 발동',
          entries: const [
            _SynergyEntry(
              label: '긍정 3+',
              condition: '긍정 극성 캐릭터 3명 이상 배치',
              effect: '아군 전체 ATK +10%',
              color: AppColor.success,
              icon: Icons.sentiment_satisfied_alt,
            ),
            _SynergyEntry(
              label: '긍정 5+',
              condition: '긍정 극성 캐릭터 5명 이상 배치',
              effect: '아군 전체 ATK +20%, ASPD +10%',
              color: AppColor.success,
              icon: Icons.sentiment_very_satisfied,
            ),
            _SynergyEntry(
              label: '부정 3+',
              condition: '부정 극성 캐릭터 3명 이상 배치',
              effect: '적 이동속도 -10%',
              color: Color(0xFF42A5F5),
              icon: Icons.sentiment_dissatisfied,
            ),
            _SynergyEntry(
              label: '부정 5+',
              condition: '부정 극성 캐릭터 5명 이상 배치',
              effect: '적 이동속도 -20%, 적 방어력 -2',
              color: Color(0xFF42A5F5),
              icon: Icons.sentiment_very_dissatisfied,
            ),
            _SynergyEntry(
              label: '감정폭발',
              condition: '긍정 3+ & 부정 3+ 동시 달성',
              effect: '5웨이브마다 전체 적에게 100 데미지',
              color: AppColor.danger,
              icon: Icons.local_fire_department,
            ),
          ],
        ),
        const SizedBox(height: 20),
        // 역할군 시너지 섹션
        _SynergySection(
          title: '역할군 시너지',
          description: '같은 역할의 캐릭터를 일정 수 이상 배치하면 발동',
          entries: const [
            _SynergyEntry(
              label: '딜러 3+',
              condition: '딜러 역할 캐릭터 3명 이상 배치',
              effect: '딜러 크리티컬 확률 +15%',
              color: AppColor.warning,
              icon: Icons.bolt,
            ),
            _SynergyEntry(
              label: '스터너 2+',
              condition: '스터너 역할 캐릭터 2명 이상 배치',
              effect: '스턴 지속시간 +0.5초',
              color: Color(0xFFAB47BC),
              icon: Icons.pause_circle_filled,
            ),
            _SynergyEntry(
              label: '버퍼 2+',
              condition: '버퍼 역할 캐릭터 2명 이상 배치',
              effect: '오라 범위 +1칸',
              color: Color(0xFF00BCD4),
              icon: Icons.shield,
            ),
            _SynergyEntry(
              label: '디버퍼 2+',
              condition: '디버퍼 역할 캐릭터 2명 이상 배치',
              effect: '디버프 지속시간 +1.0초',
              color: Color(0xFF42A5F5),
              icon: Icons.trending_down,
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

/// 시너지 섹션 — 제목 + 설명 + 시너지 카드 리스트
class _SynergySection extends StatelessWidget {
  final String title;
  final String description;
  final List<_SynergyEntry> entries;

  const _SynergySection({
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
              style: AppTextStyle.hudLabel.copyWith(color: AppColor.primary),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyle.caption.copyWith(
            fontSize: 11,
            color: AppColor.textMuted,
          ),
        ),
        const SizedBox(height: 10),
        // 시너지 카드 리스트
        ...entries.map((e) => _SynergyCard(entry: e)),
      ],
    );
  }
}

/// 시너지 항목 데이터
class _SynergyEntry {
  final String label;
  final String condition;
  final String effect;
  final Color color;
  final IconData icon;

  const _SynergyEntry({
    required this.label,
    required this.condition,
    required this.effect,
    required this.color,
    required this.icon,
  });
}

/// 시너지 카드 — 하나의 시너지 조건+효과 표시
class _SynergyCard extends StatelessWidget {
  final _SynergyEntry entry;

  const _SynergyCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: entry.color.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // 아이콘
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(entry.icon, color: entry.color, size: 22),
          ),
          const SizedBox(width: 12),
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 라벨
                Text(
                  entry.label,
                  style: AppTextStyle.hudLabel.copyWith(
                    fontSize: 13,
                    color: entry.color,
                  ),
                ),
                const SizedBox(height: 2),
                // 조건
                Text(
                  entry.condition,
                  style: const TextStyle(
                    color: AppColor.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 4),
                // 효과
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    entry.effect,
                    style: TextStyle(
                      color: entry.color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
