import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/emotion_defense_game.dart';
import '../../../data/models/character_model.dart';

/// 캐릭터 정보/강화 팝업
class CharacterInfoPopup extends StatelessWidget {
  final EmotionDefenseGame game;

  const CharacterInfoPopup({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: game.gameState,
      builder: (context, _) {
        final char = game.selectedCharacter;
        if (char == null) return const SizedBox.shrink();

        final state = game.gameState;
        final data = char.data;
        return GestureDetector(
          onTap: () => game.hideCharacterInfo(),
          child: Container(
            color: const Color(0x88000000),
            child: Center(
              child: GestureDetector(
                onTap: () {}, // 내부 탭은 닫기 방지
                child: Container(
                  width: 280,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _gradeColor(data.grade),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 헤더: 이름 + 등급 + 극성
                      Row(
                        children: [
                          Image.asset(
                            data.imagePath,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  style: AppTextStyle.hudLabel.copyWith(
                                    fontSize: 16,
                                    color: _gradeColor(data.grade),
                                  ),
                                ),
                                Text(
                                  '${_gradeName(data.grade)} | ${_polarityName(data.polarity)} | ${_roleName(data.role)}',
                                  style: AppTextStyle.hudLabel.copyWith(
                                    fontSize: 10,
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: AppColor.textPrimary,
                              size: 20,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => game.hideCharacterInfo(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // 스탯
                      _StatRow(
                        label: 'ATK',
                        value:
                            '${char.effectiveAtk.toStringAsFixed(1)} (기본 ${data.atk})',
                        upgradeLevel: state.atkUpgradeLevels[data.grade]!,
                      ),
                      _StatRow(
                        label: 'ASPD',
                        value:
                            '${char.effectiveAspd.toStringAsFixed(2)}s (기본 ${data.aspd}s)',
                        upgradeLevel: state.aspdUpgradeLevels[data.grade]!,
                      ),
                      _StatRow(label: 'Range', value: '${data.range}칸'),
                      const SizedBox(height: 8),

                      // 패시브 스킬
                      if (data.passives.isNotEmpty) ...[
                        Text(
                          '패시브',
                          style: AppTextStyle.hudLabel.copyWith(
                            fontSize: 12,
                            color: AppColor.success,
                          ),
                        ),
                        for (final p in data.passives)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            child: Text(
                              '- ${p.description}',
                              style: AppTextStyle.hudLabel.copyWith(
                                fontSize: 10,
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                      ],

                      // 액티브 스킬
                      if (data.actives.isNotEmpty) ...[
                        Text(
                          '액티브',
                          style: AppTextStyle.hudLabel.copyWith(
                            fontSize: 12,
                            color: AppColor.warning,
                          ),
                        ),
                        for (final a in data.actives)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            child: Text(
                              '- ${a.description}',
                              style: AppTextStyle.hudLabel.copyWith(
                                fontSize: 10,
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ),
                        const SizedBox(height: 4),
                      ],

                      if (data.passives.isEmpty && data.actives.isEmpty)
                        Text(
                          '스킬 없음',
                          style: AppTextStyle.hudLabel.copyWith(
                            fontSize: 10,
                            color: AppColor.textMuted,
                          ),
                        ),

                      const SizedBox(height: 4),
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

  static Color _gradeColor(Grade grade) {
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

  static String _gradeName(Grade grade) {
    switch (grade) {
      case Grade.common:
        return '일반';
      case Grade.rare:
        return '레어';
      case Grade.hero:
        return '영웅';
      case Grade.legend:
        return '전설';
    }
  }

  static String _polarityName(Polarity p) {
    switch (p) {
      case Polarity.positive:
        return '긍정';
      case Polarity.negative:
        return '부정';
      case Polarity.neutral:
        return '중립';
    }
  }

  static String _roleName(Role r) {
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
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final int? upgradeLevel;

  const _StatRow({required this.label, required this.value, this.upgradeLevel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(
              label,
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 11,
                color: AppColor.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyle.hudLabel.copyWith(fontSize: 11),
            ),
          ),
          if (upgradeLevel != null && upgradeLevel! > 0)
            Text(
              '+$upgradeLevel',
              style: AppTextStyle.hudLabel.copyWith(
                fontSize: 10,
                color: AppColor.success,
              ),
            ),
        ],
      ),
    );
  }
}
