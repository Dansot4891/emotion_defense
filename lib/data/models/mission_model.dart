/// 미션 조건 타입
enum MissionConditionType {
  killTotal, // 적 N마리 처치
  reachWave, // 웨이브 N 도달
  earnGoldTotal, // 골드 N 획득
  haveAllCommon, // 일반 6종 동시 배치
  haveAllRare, // 레어 6종 동시 배치
  haveAllHero, // 영웅 6종 동시 배치
  haveAllLegend, // 전설 4종 동시 배치
  killBoss, // 소환 보스 처치
  combineCount, // 조합 N회
}

/// 미션 보상 타입
enum MissionRewardType {
  gold,
  permanentAtk,
  permanentAspd,
  enemyLimitBonus,
  gachaCostDiscount,
}

/// 미션 보상
class MissionReward {
  final MissionRewardType type;
  final double value;
  final String description;

  const MissionReward({
    required this.type,
    required this.value,
    required this.description,
  });
}

/// 미션 데이터
class MissionData {
  final String id;
  final String name;
  final String description;
  final MissionConditionType conditionType;
  final int targetValue;
  final MissionReward reward;

  const MissionData({
    required this.id,
    required this.name,
    required this.description,
    required this.conditionType,
    required this.targetValue,
    required this.reward,
  });
}
