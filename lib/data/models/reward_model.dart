/// 보상 타입
enum RewardType {
  bonusGold,
  randomRare,
  randomHero,
  globalAtkBuff,
  globalAspdBuff,
  gachaCostDiscount,
  enemyLimitIncrease,
}

/// 보상 선택지
class RewardOption {
  final RewardType type;
  final String name;
  final String description;
  final int value; // 보상 수치 (골드 양, 비율% 등)

  const RewardOption({
    required this.type,
    required this.name,
    required this.description,
    required this.value,
  });
}
