import '../../app/localization/locale_keys.dart';
import '../models/mission_model.dart';

/// 미션 8개 정의
const List<MissionData> allMissions = [
  MissionData(
    id: 'kill_50',
    name: LocaleKeys.missionKill50Name,
    description: LocaleKeys.missionKill50Desc,
    conditionType: MissionConditionType.killTotal,
    targetValue: 50,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 100,
      description: LocaleKeys.missionKill50Reward,
    ),
  ),
  MissionData(
    id: 'kill_200',
    name: LocaleKeys.missionKill200Name,
    description: LocaleKeys.missionKill200Desc,
    conditionType: MissionConditionType.killTotal,
    targetValue: 200,
    reward: MissionReward(
      type: MissionRewardType.permanentAtk,
      value: 0.10,
      description: LocaleKeys.missionKill200Reward,
    ),
  ),
  MissionData(
    id: 'wave_10',
    name: LocaleKeys.missionWave10Name,
    description: LocaleKeys.missionWave10Desc,
    conditionType: MissionConditionType.reachWave,
    targetValue: 10,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 150,
      description: LocaleKeys.missionWave10Reward,
    ),
  ),
  MissionData(
    id: 'wave_20',
    name: LocaleKeys.missionWave20Name,
    description: LocaleKeys.missionWave20Desc,
    conditionType: MissionConditionType.reachWave,
    targetValue: 20,
    reward: MissionReward(
      type: MissionRewardType.permanentAspd,
      value: 0.10,
      description: LocaleKeys.missionWave20Reward,
    ),
  ),
  MissionData(
    id: 'gold_500',
    name: LocaleKeys.missionGold500Name,
    description: LocaleKeys.missionGold500Desc,
    conditionType: MissionConditionType.earnGoldTotal,
    targetValue: 500,
    reward: MissionReward(
      type: MissionRewardType.gachaCostDiscount,
      value: 3,
      description: LocaleKeys.missionGold500Reward,
    ),
  ),
  MissionData(
    id: 'collect_all_common',
    name: LocaleKeys.missionCollectAllCommonName,
    description: LocaleKeys.missionCollectAllCommonDesc,
    conditionType: MissionConditionType.haveAllCommon,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.permanentAtk,
      value: 0.05,
      description: LocaleKeys.missionCollectAllCommonReward,
    ),
  ),
  MissionData(
    id: 'collect_all_rare',
    name: LocaleKeys.missionCollectAllRareName,
    description: LocaleKeys.missionCollectAllRareDesc,
    conditionType: MissionConditionType.haveAllRare,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 50,
      description: LocaleKeys.missionCollectAllRareReward,
    ),
  ),
  MissionData(
    id: 'collect_all_hero',
    name: LocaleKeys.missionCollectAllHeroName,
    description: LocaleKeys.missionCollectAllHeroDesc,
    conditionType: MissionConditionType.haveAllHero,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 100,
      description: LocaleKeys.missionCollectAllHeroReward,
    ),
  ),
  MissionData(
    id: 'collect_all_legend',
    name: LocaleKeys.missionCollectAllLegendName,
    description: LocaleKeys.missionCollectAllLegendDesc,
    conditionType: MissionConditionType.haveAllLegend,
    targetValue: 4,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 200,
      description: LocaleKeys.missionCollectAllLegendReward,
    ),
  ),
  MissionData(
    id: 'kill_boss_1',
    name: LocaleKeys.missionKillBoss1Name,
    description: LocaleKeys.missionKillBoss1Desc,
    conditionType: MissionConditionType.killBoss,
    targetValue: 1,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 200,
      description: LocaleKeys.missionKillBoss1Reward,
    ),
  ),
  MissionData(
    id: 'combine_5',
    name: LocaleKeys.missionCombine5Name,
    description: LocaleKeys.missionCombine5Desc,
    conditionType: MissionConditionType.combineCount,
    targetValue: 5,
    reward: MissionReward(
      type: MissionRewardType.enemyLimitBonus,
      value: 3,
      description: LocaleKeys.missionCombine5Reward,
    ),
  ),
];
