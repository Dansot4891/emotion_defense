import '../models/mission_model.dart';

/// 미션 8개 정의
const List<MissionData> allMissions = [
  MissionData(
    id: 'kill_50',
    name: '적 50마리 처치',
    description: '적을 총 50마리 처치하세요',
    conditionType: MissionConditionType.killTotal,
    targetValue: 50,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 100,
      description: '골드 100',
    ),
  ),
  MissionData(
    id: 'kill_200',
    name: '적 200마리 처치',
    description: '적을 총 200마리 처치하세요',
    conditionType: MissionConditionType.killTotal,
    targetValue: 200,
    reward: MissionReward(
      type: MissionRewardType.permanentAtk,
      value: 0.10,
      description: 'ATK +10%',
    ),
  ),
  MissionData(
    id: 'wave_10',
    name: '웨이브 10 도달',
    description: '웨이브 10에 도달하세요',
    conditionType: MissionConditionType.reachWave,
    targetValue: 10,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 150,
      description: '골드 150',
    ),
  ),
  MissionData(
    id: 'wave_20',
    name: '웨이브 20 도달',
    description: '웨이브 20에 도달하세요',
    conditionType: MissionConditionType.reachWave,
    targetValue: 20,
    reward: MissionReward(
      type: MissionRewardType.permanentAspd,
      value: 0.10,
      description: 'ASPD +10%',
    ),
  ),
  MissionData(
    id: 'gold_500',
    name: '골드 500 획득',
    description: '골드를 총 500 획득하세요',
    conditionType: MissionConditionType.earnGoldTotal,
    targetValue: 500,
    reward: MissionReward(
      type: MissionRewardType.gachaCostDiscount,
      value: 3,
      description: '뽑기 비용 -3G',
    ),
  ),
  MissionData(
    id: 'collect_all_common',
    name: '일반 6종 배치',
    description: '일반 등급 6종을 동시에 배치하세요',
    conditionType: MissionConditionType.haveAllCommon,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.permanentAtk,
      value: 0.05,
      description: 'ATK +5%',
    ),
  ),
  MissionData(
    id: 'collect_all_rare',
    name: '레어 6종 배치',
    description: '레어 등급 6종을 동시에 배치하세요',
    conditionType: MissionConditionType.haveAllRare,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 200,
      description: '골드 200',
    ),
  ),
  MissionData(
    id: 'collect_all_hero',
    name: '영웅 6종 배치',
    description: '영웅 등급 6종을 동시에 배치하세요',
    conditionType: MissionConditionType.haveAllHero,
    targetValue: 6,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 400,
      description: '골드 400',
    ),
  ),
  MissionData(
    id: 'collect_all_legend',
    name: '전설 4종 배치',
    description: '전설 등급 4종을 동시에 배치하세요',
    conditionType: MissionConditionType.haveAllLegend,
    targetValue: 4,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 800,
      description: '골드 800',
    ),
  ),
  MissionData(
    id: 'kill_boss_1',
    name: '소환 보스 처치',
    description: '소환한 보스를 처치하세요',
    conditionType: MissionConditionType.killBoss,
    targetValue: 1,
    reward: MissionReward(
      type: MissionRewardType.gold,
      value: 200,
      description: '골드 200',
    ),
  ),
  MissionData(
    id: 'combine_5',
    name: '조합 5회',
    description: '캐릭터를 5회 조합하세요',
    conditionType: MissionConditionType.combineCount,
    targetValue: 5,
    reward: MissionReward(
      type: MissionRewardType.enemyLimitBonus,
      value: 3,
      description: '적 한도 +3',
    ),
  ),
];
