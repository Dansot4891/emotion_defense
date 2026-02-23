import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/const/style/app_color.dart';
import '../../core/game_state.dart';
import '../../data/models/enemy_model.dart';
import '../../gameplay/systems/combat_system.dart';

/// 적 컴포넌트 - 웨이포인트를 따라 이동, HP바 렌더링
class EnemyComponent extends PositionComponent {
  final EnemyData data;
  final List<Offset> pixelWaypoints;
  final GameState gameState;

  late double hp;
  late double maxHp;
  int currentWaypointIndex = 0;
  bool isDead = false;

  EnemyComponent({
    required this.data,
    required this.pixelWaypoints,
    required this.gameState,
    required double hpMultiplier,
  }) : super(size: Vector2(20, 20)) {
    maxHp = data.hp * hpMultiplier;
    hp = maxHp;

    // 스폰 위치 (첫 번째 웨이포인트)
    final spawn = pixelWaypoints.first;
    position = Vector2(spawn.dx - size.x / 2, spawn.dy - size.y / 2);
    currentWaypointIndex = 1;
  }

  /// 중심 좌표
  @override
  Vector2 get center => position + size / 2;

  @override
  void update(double dt) {
    super.update(dt);
    if (isDead) return;

    // 웨이포인트를 따라 이동
    if (currentWaypointIndex >= pixelWaypoints.length) {
      _reachEnd();
      return;
    }

    final target = pixelWaypoints[currentWaypointIndex];
    final targetVec = Vector2(target.dx, target.dy);
    final currentCenter = center;
    final direction = targetVec - currentCenter;
    final distance = direction.length;

    if (distance < 2.0) {
      currentWaypointIndex++;
    } else {
      direction.normalize();
      final move = direction * data.speed * dt;
      if (move.length > distance) {
        position = targetVec - size / 2;
      } else {
        position += move;
      }
    }
  }

  /// 데미지 받기
  void takeDamage(double atk) {
    if (isDead) return;
    final damage = CombatSystem.calculateDamage(atk, data.def);
    hp -= damage;
    if (hp <= 0) {
      die();
    }
  }

  /// 사망 처리
  void die() {
    isDead = true;
    gameState.addGold(data.rewardGold);
    gameState.onEnemyKilled();
    removeFromParent();
  }

  /// 경로 끝 도달
  void _reachEnd() {
    isDead = true;
    gameState.onEnemyLeaked();
    removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    // 적 본체 (원형)
    final bodyPaint = Paint()..color = data.color;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      bodyPaint,
    );

    // HP 바 배경
    final hpBarWidth = size.x;
    const hpBarHeight = 4.0;
    const hpBarY = -6.0;
    final bgPaint = Paint()..color = AppColor.hpBarBackground;
    canvas.drawRect(
      Rect.fromLTWH(0, hpBarY, hpBarWidth, hpBarHeight),
      bgPaint,
    );

    // HP 바 (현재 HP 비율)
    final hpRatio = (hp / maxHp).clamp(0.0, 1.0);
    final hpColor = hpRatio > 0.5
        ? AppColor.hpHigh
        : hpRatio > 0.25
            ? AppColor.hpMid
            : AppColor.hpLow;
    final hpPaint = Paint()..color = hpColor;
    canvas.drawRect(
      Rect.fromLTWH(0, hpBarY, hpBarWidth * hpRatio, hpBarHeight),
      hpPaint,
    );
  }
}
