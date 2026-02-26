import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:flutter/material.dart';

import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../data/definitions/mission_defs.dart';
import '../../../../data/models/mission_model.dart';
import '../../../../gameplay/components/character.dart';

/// 퀘스트 팝업 — 미션 탭 + 보스 소환 탭
class QuestPopup extends StatefulWidget {
  final EmotionDefenseGame game;

  const QuestPopup({super.key, required this.game});

  @override
  State<QuestPopup> createState() => _QuestPopupState();
}

class _QuestPopupState extends State<QuestPopup> {
  int _tabIndex = 0; // 0: 미션, 1: 보스 소환

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.game.gameState,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => widget.game.toggleQuestPopup(),
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
                            Text(LocaleKeys.questTitle.tr(), style: AppTextStyle.hudLabel),
                            GestureDetector(
                              onTap: () => widget.game.toggleQuestPopup(),
                              child: const Icon(
                                Icons.close,
                                color: AppColor.textSecondary,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 탭 버튼
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            _TabButton(
                              label: LocaleKeys.questMission.tr(),
                              selected: _tabIndex == 0,
                              onTap: () => setState(() => _tabIndex = 0),
                            ),
                            const SizedBox(width: 8),
                            _TabButton(
                              label: LocaleKeys.questBossSummon.tr(),
                              selected: _tabIndex == 1,
                              onTap: () => setState(() => _tabIndex = 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // 탭 내용
                      Flexible(
                        child: _tabIndex == 0
                            ? _MissionTab(game: widget.game)
                            : _BossSummonTab(game: widget.game),
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

/// 탭 버튼
class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? AppColor.primary.withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? AppColor.primary : AppColor.textMuted,
              width: selected ? 1.5 : 0.5,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? AppColor.textPrimary : AppColor.textSecondary,
              fontSize: 13,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

/// 미션 탭 — 미션 목록 + 진행률 + 보상 버튼
class _MissionTab extends StatelessWidget {
  final EmotionDefenseGame game;

  const _MissionTab({required this.game});

  @override
  Widget build(BuildContext context) {
    final characters = game.children.whereType<CharacterComponent>().toList();

    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: allMissions.length,
      separatorBuilder: (_, __) =>
          const Divider(color: AppColor.textMuted, height: 1),
      itemBuilder: (context, index) {
        final mission = allMissions[index];
        return _MissionRow(
          mission: mission,
          game: game,
          characters: characters,
        );
      },
    );
  }
}

/// 미션 한 행
class _MissionRow extends StatelessWidget {
  final MissionData mission;
  final EmotionDefenseGame game;
  final List<CharacterComponent> characters;

  const _MissionRow({
    required this.mission,
    required this.game,
    required this.characters,
  });

  @override
  Widget build(BuildContext context) {
    final state = game.gameState;
    final isClaimed = state.claimedMissionIds.contains(mission.id);
    final isCompleted = state.completedMissionIds.contains(mission.id);
    final progress = game.missionSystem.getMissionProgress(mission, characters);
    final target = mission.targetValue;
    final progressRatio = (progress / target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 미션 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mission.name.tr(),
                  style: AppTextStyle.hudLabel.copyWith(
                    fontSize: 12,
                    color: isClaimed
                        ? AppColor.textMuted
                        : AppColor.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  mission.description.tr(),
                  style: TextStyle(
                    fontSize: 10,
                    color: isClaimed
                        ? AppColor.textMuted
                        : AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                // 진행률 바
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progressRatio,
                          backgroundColor: AppColor.hpBarBackground,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isCompleted ? AppColor.success : AppColor.primary,
                          ),
                          minHeight: 4,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '$progress/$target',
                      style: TextStyle(
                        fontSize: 9,
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // 보상 표시
                Text(
                  LocaleKeys.questReward.tr(namedArgs: {'description': mission.reward.description.tr()}),
                  style: TextStyle(fontSize: 9, color: AppColor.gold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // 보상 버튼
          _RewardButton(
            isClaimed: isClaimed,
            isCompleted: isCompleted,
            onTap: () => game.claimMissionReward(mission.id),
          ),
        ],
      ),
    );
  }
}

/// 보상 수령 버튼
class _RewardButton extends StatelessWidget {
  final bool isClaimed;
  final bool isCompleted;
  final VoidCallback onTap;

  const _RewardButton({
    required this.isClaimed,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isClaimed) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColor.disabled,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          LocaleKeys.questCompleted.tr(),
          style: AppTextStyle.buttonSmall.copyWith(
            color: AppColor.textDisabled,
          ),
        ),
      );
    }

    final canClaim = isCompleted && !isClaimed;
    return GestureDetector(
      onTap: canClaim ? onTap : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: canClaim ? AppColor.success : AppColor.disabled,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          LocaleKeys.questClaim.tr(),
          style: AppTextStyle.buttonSmall.copyWith(
            color: canClaim ? AppColor.textPrimary : AppColor.textDisabled,
          ),
        ),
      ),
    );
  }
}

/// 보스 소환 탭
class _BossSummonTab extends StatelessWidget {
  final EmotionDefenseGame game;

  const _BossSummonTab({required this.game});

  @override
  Widget build(BuildContext context) {
    final state = game.gameState;
    final system = game.bossSummonSystem;
    final canSummon = system.canSummon;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 보스 정보
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppColor.enemySummonedBoss.withValues(alpha: 0.5),
              ),
            ),
            child: Column(
              children: [
                // 보스 아이콘 + 이름
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColor.enemySummonedBoss,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      LocaleKeys.enemySummonedDespairName.tr(),
                      style: AppTextStyle.hudLabel.copyWith(
                        fontSize: 16,
                        color: AppColor.enemySummonedBoss,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // 스탯 정보
                Text(
                  LocaleKeys.questBossHpInfo.tr(namedArgs: {'def': '${3 + (state.bossSummonCount)}', 'gold': '${system.currentRewardGold}'}),
                  style: TextStyle(fontSize: 10, color: AppColor.textSecondary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // 소환/처치 횟수
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatChip(label: LocaleKeys.questSummonCount.tr(), value: '${state.bossSummonCount}'),
              _StatChip(label: LocaleKeys.questKillCount.tr(), value: '${state.bossKillCount}'),
            ],
          ),
          const SizedBox(height: 12),
          // 쿨타임 안내
          if (!system.isCooldownReady)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                LocaleKeys.questCooldownInfo.tr(namedArgs: {'remaining': '${system.cooldownRemaining}', 'wave': '${system.nextAvailableWave}'}),
                style: TextStyle(fontSize: 10, color: AppColor.warning),
              ),
            ),
          // 소환 버튼
          GestureDetector(
            onTap: canSummon ? () => game.doSummonBoss() : null,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: canSummon
                    ? AppColor.enemySummonedBoss
                    : AppColor.disabled,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                canSummon ? LocaleKeys.questSummon.tr() : LocaleKeys.questSummonCooldown.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.hudLabel.copyWith(
                  color: canSummon
                      ? AppColor.textPrimary
                      : AppColor.textDisabled,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 통계 칩
class _StatChip extends StatelessWidget {
  final String label;
  final String value;

  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: AppColor.textSecondary),
        ),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyle.hudLabel.copyWith(fontSize: 16)),
      ],
    );
  }
}
