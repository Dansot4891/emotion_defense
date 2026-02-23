import 'dart:ui';

/// 적 데이터 정의
class EnemyData {
  final String id;
  final String name;
  final double hp;
  final double def;
  final double speed; // 픽셀/초
  final int rewardGold;
  final Color color; // 프로토타입용 색상
  final String description;

  const EnemyData({
    required this.id,
    required this.name,
    required this.hp,
    required this.def,
    required this.speed,
    required this.rewardGold,
    required this.color,
    required this.description,
  });
}
