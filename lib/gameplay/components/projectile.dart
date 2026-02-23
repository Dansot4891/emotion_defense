import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/constants.dart';
import 'enemy.dart';

/// 투사체 컴포넌트 - 호밍 방식으로 적 추적
class ProjectileComponent extends PositionComponent {
  final EnemyComponent target;
  final double atk;
  final Color color;

  ProjectileComponent({
    required this.target,
    required this.atk,
    required this.color,
    required Vector2 startPosition,
  }) : super(
          position: startPosition.clone(),
          size: Vector2(6, 6),
        );

  @override
  void update(double dt) {
    super.update(dt);

    // 타겟이 제거되면 자동 소멸
    if (target.isDead || target.parent == null) {
      removeFromParent();
      return;
    }

    // 호밍: 매 프레임 적 현재 위치 추적
    final targetCenter = target.center;
    final myCenter = position + size / 2;
    final direction = targetCenter - myCenter;
    final distance = direction.length;

    // 적중 판정
    if (distance < 8.0) {
      target.takeDamage(atk);
      removeFromParent();
      return;
    }

    // 이동
    direction.normalize();
    position += direction * GameConstants.projectileSpeed * dt;
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = color;
    canvas.drawCircle(
      Offset(size.x / 2, size.y / 2),
      size.x / 2,
      paint,
    );
  }
}
