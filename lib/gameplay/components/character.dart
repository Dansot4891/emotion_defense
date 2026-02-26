import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../core/const/asset/app_character_path.dart';
import '../../core/const/style/app_color.dart';
import '../../core/emotion_defense_game.dart';
import '../../core/sound_manager.dart';
import '../../data/models/character_model.dart';
import '../map/grid_map.dart';
import '../map/path_system.dart';
import 'enemy.dart';
import 'projectile.dart';
import 'tile.dart';

/// 캐릭터 컴포넌트 - 사거리 내 적 탐색, 쿨다운 기반 자동 공격, 드래그 이동
class CharacterComponent extends PositionComponent
    with DragCallbacks, TapCallbacks, HasGameReference<EmotionDefenseGame> {
  final CharacterData data;
  final GridMap gridMap;

  TileComponent currentTile;
  double _attackCooldown = 0;

  /// 버프 배율 (매 프레임 리셋 후 오라 시스템에서 재계산)
  double atkMultiplier = 1.0;
  double aspdMultiplier = 1.0;

  /// 드래그 관련
  bool _isDragging = false;

  /// idle 애니메이션 (둥둥 떠있는 효과)
  double _idleTime = 0;
  final double _idlePhase = math.Random().nextDouble() * math.pi * 2;

  /// 캐릭터 스프라이트
  ui.Image? _spriteImage;

  CharacterComponent({
    required this.data,
    required this.currentTile,
    required this.gridMap,
  }) : super(size: Vector2.all(gridMap.tileSize * 0.95)) {
    _updatePositionFromTile();
    currentTile.occupant = this;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final flamePath = AppCharacterPath.toFlamePath(data.imagePath);
    _spriteImage = game.images.fromCache(flamePath);
  }

  /// 등급별 강화 레벨 (GameState에서 조회)
  int get atkUpgradeLevel => game.gameState.atkUpgradeLevels[data.grade]!;
  int get aspdUpgradeLevel => game.gameState.aspdUpgradeLevels[data.grade]!;

  /// 실효 ATK (버프 + 강화)
  double get effectiveAtk =>
      data.atk * atkMultiplier * (1 + atkUpgradeLevel * 0.10);

  /// 실효 ASPD 쿨다운 (버프 + 강화로 감소)
  double get effectiveAspd =>
      data.aspd / (aspdMultiplier * (1 + aspdUpgradeLevel * 0.10));

  /// 버프 리셋 (매 프레임 오라 계산 전 호출)
  void resetBuffs() {
    atkMultiplier = 1.0;
    aspdMultiplier = 1.0;
  }

  /// 히트 영역을 타일 전체로 확장 (타일 아무 곳이나 탭/드래그 가능)
  @override
  bool containsLocalPoint(Vector2 point) {
    final tileSize = currentTile.size;
    final offset = (tileSize - size) / 2;
    return point.x >= -offset.x && point.x <= size.x + offset.x &&
        point.y >= -offset.y && point.y <= size.y + offset.y;
  }

  /// 타일 중심에 캐릭터 배치
  void _updatePositionFromTile() {
    position = Vector2(
      currentTile.position.x + (currentTile.size.x - size.x) / 2,
      currentTile.position.y + (currentTile.size.y - size.y) / 2,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // idle 애니메이션 타이머 (드래그 중에도 계속 진행)
    _idleTime += dt;

    if (_isDragging) return;

    // 쿨다운 감소
    _attackCooldown -= dt;
    if (_attackCooldown > 0) return;

    // 사거리 내 적 탐색 (가장 경로 앞선 적 우선)
    final target = _findTarget();
    if (target != null) {
      _attack(target);
      _attackCooldown = effectiveAspd;
    }
  }

  /// 사거리 내 적 찾기 - currentWaypointIndex가 가장 높은 적 우선
  EnemyComponent? _findTarget() {
    final rangePixels = data.range * gridMap.tileSize;
    final myCenter = position + size / 2;

    EnemyComponent? bestTarget;
    int bestProgress = -1;

    final enemies = parent?.children.whereType<EnemyComponent>() ?? [];
    for (final enemy in enemies) {
      if (enemy.isDead) continue;
      final dist = (enemy.center - myCenter).length;
      if (dist <= rangePixels && enemy.currentWaypointIndex > bestProgress) {
        bestProgress = enemy.currentWaypointIndex;
        bestTarget = enemy;
      }
    }
    return bestTarget;
  }

  /// 투사체 발사
  void _attack(EnemyComponent target) {
    SoundManager.instance.play(Sfx.attack);
    final projectile = ProjectileComponent(
      target: target,
      atk: effectiveAtk,
      color: data.color,
      startPosition: position + size / 2 - Vector2(3, 3),
      sourceData: data,
    );
    parent?.add(projectile);
  }

  // --- 탭 ---

  @override
  void onTapUp(TapUpEvent event) {
    if (game.isSellMode) {
      game.doSell(this);
    } else {
      game.showCharacterInfo(this);
    }
  }

  // --- 드래그 이동 ---

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragging = true;
    priority = 100; // 드래그 중 최상위 렌더링
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragging = false;
    priority = 0;

    // 드롭된 위치의 타일 찾기
    final centerPos = position + size / 2;
    final targetTile = gridMap.getTileAtPixel(centerPos.x, centerPos.y);

    if (targetTile != null &&
        targetTile.tileType == TileType.placement &&
        targetTile != currentTile) {
      final otherChar = targetTile.occupant;
      if (otherChar != null) {
        // 교체: 상대를 내 타일로 이동
        otherChar.currentTile = currentTile;
        currentTile.occupant = otherChar;
        otherChar._updatePositionFromTile();
      } else {
        currentTile.occupant = null;
      }
      // 나를 새 타일에 배치
      currentTile = targetTile;
      currentTile.occupant = this;
      _updatePositionFromTile();
      SoundManager.instance.play(Sfx.place);
    } else {
      // 유효하지 않은 위치 → 원래 위치로 복귀
      _updatePositionFromTile();
    }
  }

  @override
  void render(Canvas canvas) {
    // 사거리 표시 (드래그 중에만)
    if (_isDragging) {
      final rangePaint = Paint()
        ..color = AppColor.rangeIndicator
        ..style = PaintingStyle.fill;
      final rangePixels = data.range * gridMap.tileSize;
      canvas.drawCircle(
        Offset(size.x / 2, size.y / 2),
        rangePixels,
        rangePaint,
      );
    }

    // 캐릭터 스프라이트 렌더링 (idle 둥둥 애니메이션 적용)
    if (_spriteImage != null) {
      final idleOffsetY = math.sin(_idleTime * 2.5 + _idlePhase) * (size.y * 0.04);

      final src = Rect.fromLTWH(
        0, 0,
        _spriteImage!.width.toDouble(),
        _spriteImage!.height.toDouble(),
      );
      final dst = Rect.fromLTWH(0, idleOffsetY, size.x, size.y);
      canvas.drawImageRect(_spriteImage!, src, dst, Paint());
    }
  }

  /// 캐릭터 제거 (판매 등)
  void removeCharacter() {
    currentTile.occupant = null;
    removeFromParent();
  }
}
