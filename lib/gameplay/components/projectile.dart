import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/constants.dart';
import '../../data/models/character_model.dart';
import '../../data/models/effect_model.dart';
import '../../data/models/status_effect_model.dart';
import 'enemy.dart';

/// 투사체 컴포넌트 - 호밍 방식으로 적 추적 + 액티브 스킬 처리
class ProjectileComponent extends PositionComponent {
  final EnemyComponent target;
  final double atk;
  final Color color;
  final CharacterData? sourceData;

  /// 시너지 보너스
  double extraCritBonus = 0.0;
  double extraStunDuration = 0.0;
  double extraDebufferDuration = 0.0;

  static final Random _random = Random();

  ProjectileComponent({
    required this.target,
    required this.atk,
    required this.color,
    required Vector2 startPosition,
    this.sourceData,
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
      _processActiveEffects(target);
      removeFromParent();
      return;
    }

    // 이동
    direction.normalize();
    position += direction * GameConstants.projectileSpeed * dt;
  }

  /// 액티브 스킬 처리 — 각 active에 대해 확률 판정
  void _processActiveEffects(EnemyComponent hitTarget) {
    if (sourceData == null) return;

    for (final active in sourceData!.actives) {
      if (_random.nextDouble() > active.procChance) continue;

      switch (active.type) {
        case ActiveType.critical:
          // 크리티컬 — 추가 데미지
          final critDamage = atk * (active.value - 1.0 + extraCritBonus);
          hitTarget.takeDamage(critDamage);
          break;

        case ActiveType.stun:
          hitTarget.applyStatusEffect(StatusEffect(
            type: StatusEffectType.stun,
            value: 0,
            remainingDuration: active.duration + extraStunDuration,
          ));
          break;

        case ActiveType.slow:
          hitTarget.applyStatusEffect(StatusEffect(
            type: StatusEffectType.slow,
            value: active.value,
            remainingDuration: active.duration + extraDebufferDuration,
          ));
          break;

        case ActiveType.defBreak:
          hitTarget.applyStatusEffect(StatusEffect(
            type: StatusEffectType.defBreak,
            value: active.value,
            remainingDuration: active.duration + extraDebufferDuration,
          ));
          break;

        case ActiveType.aoeDamage:
          _applyAoeDamage(hitTarget, active.value);
          break;
      }
    }
  }

  /// 범위 데미지 — 주변 60px 적에게 비율 데미지
  void _applyAoeDamage(EnemyComponent center, double ratio) {
    final enemies = parent?.children.whereType<EnemyComponent>() ?? [];
    for (final enemy in enemies) {
      if (enemy.isDead || enemy == center) continue;
      final dist = (enemy.center - center.center).length;
      if (dist <= 60.0) {
        enemy.takeDamage(atk * ratio);
      }
    }
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
