import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/emotion_defense_game.dart';
import '../../data/definitions/upgrade_defs.dart';
import '../../data/models/character_model.dart';

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
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: data.color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.charBorder,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                data.name[0],
                                style: AppTextStyle.charLabel,
                              ),
                            ),
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
                            icon: const Icon(Icons.close,
                                color: AppColor.textPrimary, size: 20),
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
                        upgradeLevel: char.atkUpgradeLevel,
                      ),
                      _StatRow(
                        label: 'ASPD',
                        value:
                            '${char.effectiveAspd.toStringAsFixed(2)}s (기본 ${data.aspd}s)',
                        upgradeLevel: char.aspdUpgradeLevel,
                      ),
                      _StatRow(
                        label: 'Range',
                        value: '${data.range}칸',
                      ),
                      const SizedBox(height: 8),

                      // 패시브 스킬
                      if (data.passives.isNotEmpty) ...[
                        Text('패시브',
                            style: AppTextStyle.hudLabel.copyWith(
                                fontSize: 12, color: AppColor.success)),
                        for (final p in data.passives)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            child: Text(
                              '- ${p.description}',
                              style: AppTextStyle.hudLabel.copyWith(
                                  fontSize: 10,
                                  color: AppColor.textSecondary),
                            ),
                          ),
                        const SizedBox(height: 4),
                      ],

                      // 액티브 스킬
                      if (data.actives.isNotEmpty) ...[
                        Text('액티브',
                            style: AppTextStyle.hudLabel.copyWith(
                                fontSize: 12, color: AppColor.warning)),
                        for (final a in data.actives)
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 2),
                            child: Text(
                              '- ${a.description}',
                              style: AppTextStyle.hudLabel.copyWith(
                                  fontSize: 10,
                                  color: AppColor.textSecondary),
                            ),
                          ),
                        const SizedBox(height: 4),
                      ],

                      if (data.passives.isEmpty && data.actives.isEmpty)
                        Text(
                          '스킬 없음',
                          style: AppTextStyle.hudLabel.copyWith(
                              fontSize: 10, color: AppColor.textMuted),
                        ),

                      const SizedBox(height: 12),

                      // 강화 버튼
                      Row(
                        children: [
                          Expanded(
                            child: _UpgradeButton(
                              label: 'ATK 강화',
                              level: char.atkUpgradeLevel,
                              cost: char.atkUpgradeLevel < maxUpgradeLevel
                                  ? upgradeCosts[char.atkUpgradeLevel]
                                  : 0,
                              enabled: game.upgradeSystem.canUpgradeAtk(char),
                              onTap: () {
                                game.doUpgradeAtk(char);
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _UpgradeButton(
                              label: 'ASPD 강화',
                              level: char.aspdUpgradeLevel,
                              cost: char.aspdUpgradeLevel < maxUpgradeLevel
                                  ? upgradeCosts[char.aspdUpgradeLevel]
                                  : 0,
                              enabled: game.upgradeSystem.canUpgradeAspd(char),
                              onTap: () {
                                game.doUpgradeAspd(char);
                              },
                            ),
                          ),
                        ],
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

  static Color _gradeColor(Grade grade) {
    switch (grade) {
      case Grade.common:
        return AppColor.textSecondary;
      case Grade.rare:
        return const Color(0xFF42A5F5);
      case Grade.hero:
        return const Color(0xFFAB47BC);
      case Grade.legend:
        return AppColor.gold;
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

  const _StatRow({
    required this.label,
    required this.value,
    this.upgradeLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Text(label,
                style: AppTextStyle.hudLabel
                    .copyWith(fontSize: 11, color: AppColor.textSecondary)),
          ),
          Expanded(
            child: Text(value,
                style: AppTextStyle.hudLabel.copyWith(fontSize: 11)),
          ),
          if (upgradeLevel != null && upgradeLevel! > 0)
            Text('+$upgradeLevel',
                style: AppTextStyle.hudLabel
                    .copyWith(fontSize: 10, color: AppColor.success)),
        ],
      ),
    );
  }
}

class _UpgradeButton extends StatelessWidget {
  final String label;
  final int level;
  final int cost;
  final bool enabled;
  final VoidCallback onTap;

  const _UpgradeButton({
    required this.label,
    required this.level,
    required this.cost,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMax = level >= maxUpgradeLevel;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: enabled ? AppColor.primary : AppColor.disabled,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: AppTextStyle.buttonSmall.copyWith(fontSize: 10),
            ),
            Text(
              isMax ? 'MAX' : '${cost}G (Lv$level)',
              style: AppTextStyle.buttonSmall.copyWith(
                fontSize: 9,
                color:
                    enabled ? AppColor.gold : AppColor.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
