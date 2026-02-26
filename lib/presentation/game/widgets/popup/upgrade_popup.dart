import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../data/definitions/upgrade_defs.dart';
import '../../../../data/models/character_model.dart';

/// 강화 팝업 — 등급별 ATK/ASPD 강화
class UpgradePopup extends StatelessWidget {
  final EmotionDefenseGame game;

  const UpgradePopup({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => game.toggleUpgradePopup(),
          child: Container(
            color: AppColor.background,
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
                      // 고정 헤더
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('강화', style: AppTextStyle.hudLabel),
                            GestureDetector(
                              onTap: () => game.toggleUpgradePopup(),
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
                      // 스크롤 가능한 등급 섹션
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          children: [
                            _GradeUpgradeSection(
                              grade: Grade.common,
                              gradeName: '일반',
                              gradeColor: AppColor.gradeCommon,
                              game: game,
                            ),
                            const SizedBox(height: 8),
                            _GradeUpgradeSection(
                              grade: Grade.rare,
                              gradeName: '레어',
                              gradeColor: AppColor.gradeRare,
                              game: game,
                            ),
                            const SizedBox(height: 8),
                            _GradeUpgradeSection(
                              grade: Grade.hero,
                              gradeName: '영웅',
                              gradeColor: AppColor.gradeHero,
                              game: game,
                            ),
                            const SizedBox(height: 8),
                            _GradeUpgradeSection(
                              grade: Grade.legend,
                              gradeName: '전설',
                              gradeColor: AppColor.gradeLegend,
                              game: game,
                            ),
                          ],
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

/// 등급 하나에 대한 강화 섹션
class _GradeUpgradeSection extends StatelessWidget {
  final Grade grade;
  final String gradeName;
  final Color gradeColor;
  final EmotionDefenseGame game;

  const _GradeUpgradeSection({
    required this.grade,
    required this.gradeName,
    required this.gradeColor,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    final state = game.gameState;
    final atkLevel = state.atkUpgradeLevels[grade]!;
    final aspdLevel = state.aspdUpgradeLevels[grade]!;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: gradeColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 등급 이름 + 레벨 표시
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: gradeColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: gradeColor, width: 1),
                ),
                child: Text(
                  gradeName,
                  style: TextStyle(
                    color: gradeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                'ATK+${(atkLevel * 10)}%  ASPD+${(aspdLevel * 10)}%',
                style: AppTextStyle.hudLabel.copyWith(
                  fontSize: 10,
                  color: AppColor.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // 강화 버튼
          Row(
            spacing: 8,
            children: [
              AppButton.basePrimary(
                borderRadius: 8,
                verticalPadding: 8,
                isExpanded: true,
                textAlign: TextAlign.center,
                text:
                    'ATK 강화 +${(atkLevel)}\n${atkLevel < maxUpgradeLevel ? upgradeCosts[atkLevel] : 0}G',
                onTap: () => game.doUpgradeAtk(grade),
                enabled: game.upgradeSystem.canUpgradeAtk(grade),
              ),
              AppButton.basePrimary(
                borderRadius: 8,
                verticalPadding: 8,
                isExpanded: true,
                textAlign: TextAlign.center,
                text:
                    'ASPD 강화 +${(aspdLevel)}\n${aspdLevel < maxUpgradeLevel ? upgradeCosts[aspdLevel] : 0}G',
                onTap: () => game.doUpgradeAspd(grade),
                enabled: game.upgradeSystem.canUpgradeAtk(grade),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
