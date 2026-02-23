/// 패시브 효과 타입
enum PassiveType {
  allyAtkBuff, // 주변 아군 ATK 증가
  allyAspdBuff, // 주변 아군 ASPD 증가
  enemySpdDebuff, // 주변 적 이동속도 감소
  enemyDefDebuff, // 주변 적 방어력 감소
}

/// 액티브 효과 타입
enum ActiveType {
  critical, // 크리티컬 (추가 데미지)
  stun, // 스턴 (이동 정지)
  slow, // 감속 (이동속도 감소)
  defBreak, // 방어력 감소
  aoeDamage, // 범위 데미지
}

/// 패시브 스킬 데이터 (오라 효과)
class PassiveData {
  final PassiveType type;
  final int range; // 칸 단위
  final double value; // 비율 (0.10 = 10%)
  final String description;

  const PassiveData({
    required this.type,
    required this.range,
    required this.value,
    required this.description,
  });
}

/// 액티브 스킬 데이터 (공격 시 확률 발동)
class ActiveData {
  final ActiveType type;
  final double procChance; // 발동 확률 (0.15 = 15%)
  final double value; // 효과 수치 (크리티컬 배율, 감속 비율 등)
  final double duration; // 지속 시간 (초), 크리티컬은 0
  final String description;

  const ActiveData({
    required this.type,
    required this.procChance,
    required this.value,
    this.duration = 0,
    required this.description,
  });
}
