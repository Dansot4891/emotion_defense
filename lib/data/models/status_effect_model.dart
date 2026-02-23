/// 상태 효과 타입
enum StatusEffectType { stun, slow, defBreak }

/// 적에게 적용되는 런타임 상태 효과
class StatusEffect {
  final StatusEffectType type;
  final double value; // 감속 비율 또는 방깎 수치
  double remainingDuration;

  StatusEffect({
    required this.type,
    required this.value,
    required this.remainingDuration,
  });

  /// 시간 경과 처리, 만료 시 true 반환
  bool tick(double dt) {
    remainingDuration -= dt;
    return remainingDuration <= 0;
  }
}
