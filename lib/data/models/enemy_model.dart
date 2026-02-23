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

  // 보스 여부
  final bool isBoss;

  // 분열 (번아웃)
  final bool splits;
  final int splitCount;
  final String? splitIntoId;

  // 주변 버프 (트라우마)
  final bool buffsNearby;
  final double nearbyBuffRange; // 픽셀
  final double nearbyBuffValue; // 초당 HP 회복량

  const EnemyData({
    required this.id,
    required this.name,
    required this.hp,
    required this.def,
    required this.speed,
    required this.rewardGold,
    required this.color,
    required this.description,
    this.isBoss = false,
    this.splits = false,
    this.splitCount = 0,
    this.splitIntoId,
    this.buffsNearby = false,
    this.nearbyBuffRange = 0,
    this.nearbyBuffValue = 0,
  });
}
