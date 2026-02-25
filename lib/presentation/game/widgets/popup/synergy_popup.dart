import 'package:flutter/material.dart';

import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../gameplay/systems/synergy_system.dart';

/// 시너지 상세 팝업 — 극성/역할군 시너지 조건 + 진행률 표시
class SynergyPopup extends StatelessWidget {
  final EmotionDefenseGame game;

  const SynergyPopup({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final synergy = game.synergyBonuses;
        return GestureDetector(
          onTap: () => game.toggleSynergyPopup(),
          child: Container(
            color: const Color(0x88000000),
            child: SafeArea(
              child: GestureDetector(
                onTap: () {}, // 내부 탭은 닫기 방지
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.overlay,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColor.primary, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 헤더
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('시너지', style: AppTextStyle.hudLabel),
                            GestureDetector(
                              onTap: () => game.toggleSynergyPopup(),
                              child: const Icon(
                                Icons.close,
                                color: AppColor.textSecondary,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 현재 배치 요약
                      _PlacementSummary(synergy: synergy),
                      const SizedBox(height: 12),
                      // 시너지 목록
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 극성 시너지 섹션
                              _SectionHeader(label: '극성 시너지'),
                              const SizedBox(height: 6),
                              _SynergyRow(
                                label: '긍정 3+',
                                effect: 'ATK +10%',
                                current: synergy.positiveCount,
                                required_: 3,
                                active: synergy.positiveCount >= 3,
                                color: AppColor.success,
                              ),
                              _SynergyRow(
                                label: '긍정 5+',
                                effect: 'ATK +20%, ASPD +10%',
                                current: synergy.positiveCount,
                                required_: 5,
                                active: synergy.positiveCount >= 5,
                                color: AppColor.success,
                              ),
                              _SynergyRow(
                                label: '부정 3+',
                                effect: '적 이동속도 -10%',
                                current: synergy.negativeCount,
                                required_: 3,
                                active: synergy.negativeCount >= 3,
                                color: const Color(0xFF42A5F5),
                              ),
                              _SynergyRow(
                                label: '부정 5+',
                                effect: '적 이동속도 -20%, 적 방어 -2',
                                current: synergy.negativeCount,
                                required_: 5,
                                active: synergy.negativeCount >= 5,
                                color: const Color(0xFF42A5F5),
                              ),
                              _SynergyRow(
                                label: '긍정 3+ & 부정 3+',
                                effect: '감정폭발 (5웨이브마다 전체 100 데미지)',
                                current:
                                    synergy.positiveCount >= 3 &&
                                        synergy.negativeCount >= 3
                                    ? 1
                                    : 0,
                                required_: 1,
                                active: synergy.emotionExplosion,
                                color: AppColor.danger,
                                customProgress:
                                    '긍정 ${synergy.positiveCount}/3, 부정 ${synergy.negativeCount}/3',
                              ),
                              const SizedBox(height: 12),
                              // 역할군 시너지 섹션
                              _SectionHeader(label: '역할군 시너지'),
                              const SizedBox(height: 6),
                              _SynergyRow(
                                label: '딜러 3+',
                                effect: '크리티컬 +15%',
                                current: synergy.dealerCount,
                                required_: 3,
                                active: synergy.dealerCritBonus > 0,
                                color: AppColor.warning,
                              ),
                              _SynergyRow(
                                label: '스터너 2+',
                                effect: '스턴 +0.5초',
                                current: synergy.stunnerCount,
                                required_: 2,
                                active: synergy.stunDurationBonus > 0,
                                color: const Color(0xFFAB47BC),
                              ),
                              _SynergyRow(
                                label: '버퍼 2+',
                                effect: '오라 범위 +1칸',
                                current: synergy.bufferCount,
                                required_: 2,
                                active: synergy.bufferRangeBonus > 0,
                                color: const Color(0xFF00BCD4),
                              ),
                              _SynergyRow(
                                label: '디버퍼 2+',
                                effect: '디버프 +1.0초',
                                current: synergy.debufferCount,
                                required_: 2,
                                active: synergy.debufferDurationBonus > 0,
                                color: const Color(0xFF42A5F5),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 현재 배치 요약 — 극성 + 역할군 카운트 칩
class _PlacementSummary extends StatelessWidget {
  final SynergyBonuses synergy;

  const _PlacementSummary({required this.synergy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          _CountChip(
            label: '긍정',
            count: synergy.positiveCount,
            color: AppColor.success,
          ),
          _CountChip(
            label: '부정',
            count: synergy.negativeCount,
            color: const Color(0xFF42A5F5),
          ),
          _CountChip(
            label: '딜러',
            count: synergy.dealerCount,
            color: AppColor.warning,
          ),
          _CountChip(
            label: '스터너',
            count: synergy.stunnerCount,
            color: const Color(0xFFAB47BC),
          ),
          _CountChip(
            label: '버퍼',
            count: synergy.bufferCount,
            color: const Color(0xFF00BCD4),
          ),
          _CountChip(
            label: '디버퍼',
            count: synergy.debufferCount,
            color: const Color(0xFF42A5F5),
          ),
        ],
      ),
    );
  }
}

/// 카운트 칩
class _CountChip extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _CountChip({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: count > 0 ? color.withValues(alpha: 0.15) : Colors.transparent,
        border: Border.all(
          color: count > 0 ? color : AppColor.textMuted,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$label $count',
        style: TextStyle(
          color: count > 0 ? color : AppColor.textMuted,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// 섹션 헤더
class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Text(label, style: AppTextStyle.hudLabel.copyWith(fontSize: 12)),
    );
  }
}

/// 시너지 한 행 — 조건 + 진행률 + 효과
class _SynergyRow extends StatelessWidget {
  final String label;
  final String effect;
  final int current;
  final int required_;
  final bool active;
  final Color color;
  final String? customProgress;

  const _SynergyRow({
    required this.label,
    required this.effect,
    required this.current,
    required this.required_,
    required this.active,
    required this.color,
    this.customProgress,
  });

  @override
  Widget build(BuildContext context) {
    final progressRatio = (current / required_).clamp(0.0, 1.0);
    final displayColor = active ? color : AppColor.textMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 조건 + 카운트
          Row(
            children: [
              // 활성 표시 아이콘
              Icon(
                active ? Icons.check_circle : Icons.radio_button_unchecked,
                color: displayColor,
                size: 14,
              ),
              const SizedBox(width: 6),
              // 조건 라벨
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: displayColor,
                    fontSize: 11,
                    fontWeight: active ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              // 카운트
              Text(
                customProgress ?? '$current/$required_',
                style: TextStyle(color: displayColor, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 3),
          // 진행률 바
          Row(
            children: [
              const SizedBox(width: 20), // 아이콘 정렬
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progressRatio,
                    backgroundColor: AppColor.hpBarBackground,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      active ? color : AppColor.textMuted,
                    ),
                    minHeight: 3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          // 효과 설명
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              effect,
              style: TextStyle(
                color: active
                    ? color.withValues(alpha: 0.85)
                    : AppColor.textMuted,
                fontSize: 9,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
