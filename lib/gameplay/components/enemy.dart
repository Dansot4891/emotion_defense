import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/const/asset/app_enemy_path.dart';
import '../../core/const/style/app_color.dart';
import '../../core/emotion_defense_game.dart';
import '../../core/game_state.dart';
import '../../data/definitions/enemy_defs.dart';
import '../../data/models/enemy_model.dart';
import '../../data/models/status_effect_model.dart';
import '../../gameplay/systems/combat_system.dart';

/// 적 컴포넌트 - 웨이포인트를 따라 이동, HP바 렌더링, 상태 효과
class EnemyComponent extends PositionComponent
    with HasGameReference<EmotionDefenseGame> {
  final EnemyData data;
  final List<Offset> pixelWaypoints;
  final GameState gameState;
  final int wave;
  final double _tileSize;

  late double hp;
  late double maxHp;
  int currentWaypointIndex = 0;
  bool isDead = false;

  /// 상태 효과 목록
  final List<StatusEffect> statusEffects = [];

  /// 오라 디버프 (매 프레임 리셋)
  double auraSpeedMultiplier = 1.0;
  double auraDefReduction = 0.0;

  /// 적 스프라이트
  ui.Image? _spriteImage;

  EnemyComponent({
    required this.data,
    required this.pixelWaypoints,
    required this.gameState,
    required double hpMultiplier,
    required this.wave,
    double tileSize = 40,
  }) : _tileSize = tileSize,
       super(size: Vector2.all(data.isBoss ? tileSize * 1 : tileSize * 0.65)) {
    maxHp = data.hp * hpMultiplier * gameState.difficulty.hpMult;
    hp = maxHp;

    // 스폰 위치 (첫 번째 웨이포인트)
    final spawn = pixelWaypoints.first;
    position = Vector2(spawn.dx - size.x / 2, spawn.dy - size.y / 2);
    currentWaypointIndex = 1;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final imagePath = AppEnemyPath.getImagePath(
      wave: wave,
      isBoss: data.isBoss,
      isSummonedBoss: data.isSummonedBoss,
    );
    _spriteImage = game.images.fromCache(AppEnemyPath.toFlamePath(imagePath));
  }

  /// 중심 좌표
  @override
  Vector2 get center => position + size / 2;

  /// 스턴 여부
  bool get isStunned =>
      statusEffects.any((e) => e.type == StatusEffectType.stun);

  /// 감속 배율 (상태 효과)
  double get speedMultiplier {
    double mult = 1.0;
    for (final e in statusEffects) {
      if (e.type == StatusEffectType.slow) {
        mult -= e.value;
      }
    }
    return mult.clamp(0.1, 1.0);
  }

  /// 실효 방어력 (난이도 + 상태 효과 + 오라 디버프)
  double get effectiveDef {
    double defReduction = auraDefReduction;
    for (final e in statusEffects) {
      if (e.type == StatusEffectType.defBreak) {
        defReduction += e.value;
      }
    }
    return (data.def * gameState.difficulty.defMult - defReduction).clamp(
      0.0,
      double.infinity,
    );
  }

  /// 실효 이동속도 (난이도 적용)
  double get effectiveSpeed =>
      data.speed *
      gameState.difficulty.speedMult *
      speedMultiplier *
      auraSpeedMultiplier;

  /// 상태 효과 적용
  void applyStatusEffect(StatusEffect effect) {
    statusEffects.add(effect);
  }

  /// 오라 디버프 리셋 (매 프레임)
  void resetAuraDebuffs() {
    auraSpeedMultiplier = 1.0;
    auraDefReduction = 0.0;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isDead) return;

    // 상태 효과 틱 처리 (만료된 효과 제거)
    statusEffects.removeWhere((e) => e.tick(dt));

    // 트라우마 버프: 주변 적 HP 회복
    if (data.buffsNearby) {
      _processNearbyBuff(dt);
    }

    // 스턴 시 이동 정지
    if (isStunned) return;

    // 웨이포인트를 따라 이동 (순환 루프)
    if (currentWaypointIndex >= pixelWaypoints.length) {
      currentWaypointIndex = 0;
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
      final move = direction * effectiveSpeed * dt;
      if (move.length > distance) {
        position = targetVec - size / 2;
      } else {
        position += move;
      }
    }
  }

  /// 트라우마 버프 - 주변 적 HP 회복
  void _processNearbyBuff(double dt) {
    final enemies = parent?.children.whereType<EnemyComponent>() ?? [];
    for (final enemy in enemies) {
      if (enemy == this || enemy.isDead) continue;
      final dist = (enemy.center - center).length;
      if (dist <= data.nearbyBuffRange) {
        enemy.hp = (enemy.hp + data.nearbyBuffValue * dt).clamp(0, enemy.maxHp);
      }
    }
  }

  /// 데미지 받기
  void takeDamage(double atk) {
    if (isDead) return;
    final damage = CombatSystem.calculateDamage(atk, effectiveDef);
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

    // 소환 보스 처치 기록
    if (data.isSummonedBoss) {
      gameState.onSummonedBossKilled();
    }

    // 분열 처리 (번아웃 등)
    if (data.splits && data.splitIntoId != null) {
      for (int i = 0; i < data.splitCount; i++) {
        final splitData = getEnemyData(data.splitIntoId!);
        final splitEnemy = EnemyComponent(
          data: splitData,
          pixelWaypoints: pixelWaypoints,
          gameState: gameState,
          hpMultiplier: 1.0,
          wave: wave,
          tileSize: _tileSize,
        );
        // 현재 위치 근처에 스폰
        splitEnemy.position = position.clone() + Vector2(i * 10.0 - 5, 0);
        splitEnemy.currentWaypointIndex = currentWaypointIndex;
        parent?.add(splitEnemy);
        gameState.onEnemySpawned();
      }
    }

    removeFromParent();
  }

  @override
  void render(Canvas canvas) {
    // 적 스프라이트 렌더링
    if (_spriteImage != null) {
      final src = Rect.fromLTWH(
        0,
        0,
        _spriteImage!.width.toDouble(),
        _spriteImage!.height.toDouble(),
      );
      final dst = Rect.fromLTWH(0, 0, size.x, size.y);
      canvas.drawImageRect(_spriteImage!, src, dst, Paint());
    } else {
      // 이미지 없으면 기존 원형 폴백
      final bodyPaint = Paint()..color = data.color;
      canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, bodyPaint);
    }

    // 스턴 표시 (노란 테두리)
    if (isStunned) {
      final stunPaint = Paint()
        ..color = const Color(0xFFFFFF00)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(
        Offset(size.x / 2, size.y / 2),
        size.x / 2 + 1,
        stunPaint,
      );
    }

    // HP 바 배경
    final hpBarWidth = size.x;
    const hpBarHeight = 4.0;
    const hpBarY = -6.0;
    final bgPaint = Paint()..color = AppColor.hpBarBackground;
    canvas.drawRect(Rect.fromLTWH(0, hpBarY, hpBarWidth, hpBarHeight), bgPaint);

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
