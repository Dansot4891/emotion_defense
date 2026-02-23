import 'dart:math';

/// 전투 시스템 - 데미지 계산
class CombatSystem {
  CombatSystem._();

  /// 데미지 계산: max(1, atk - def)
  static double calculateDamage(double atk, double def) {
    return max(1.0, atk - def);
  }
}
