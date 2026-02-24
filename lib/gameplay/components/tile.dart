import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/emotion_defense_game.dart';
import '../map/path_system.dart';
import 'character.dart';

/// 격자 맵의 개별 타일 컴포넌트
class TileComponent extends PositionComponent
    with TapCallbacks, HasGameReference<EmotionDefenseGame> {
  final int row;
  final int col;
  final TileType tileType;

  /// 경로 타일의 이동 방향 (화살표 렌더링용, 경로가 아니면 null)
  final PathDirection? pathDirection;

  /// 이 타일에 배치된 캐릭터 (없으면 null)
  CharacterComponent? occupant;

  TileComponent({
    required this.row,
    required this.col,
    required this.tileType,
    required Vector2 position,
    required Vector2 size,
    this.pathDirection,
  }) : super(position: position, size: size);

  /// 캐릭터 배치 가능 여부
  bool get canPlace => tileType == TileType.placement && occupant == null;

  // --- 타일 탭 → 캐릭터에게 전달 ---

  @override
  void onTapUp(TapUpEvent event) {
    final char = occupant;
    if (char == null) return;

    if (game.isSellMode) {
      game.doSell(char);
    } else {
      game.showCharacterInfo(char);
    }
  }

  // === 렌더링 상수 ===
  static const double _padding = 2.0;
  static const double _radius = 4.0;

  @override
  void render(Canvas canvas) {
    switch (tileType) {
      case TileType.path:
        _renderPath(canvas);
      case TileType.placement:
        _renderPlacement(canvas);
      case TileType.spawn:
        _renderSpawn(canvas);
      case TileType.blocked:
        _renderBlocked(canvas);
    }
  }

  /// 경로 타일: 어두운 보라 베이스 + 보라빛 glow 테두리 + 방향 화살표
  void _renderPath(Canvas canvas) {
    final outerRect = Rect.fromLTWH(0, 0, size.x, size.y);
    final innerRect = outerRect.deflate(_padding);
    final rrect = RRect.fromRectAndRadius(innerRect, const Radius.circular(_radius));

    // 베이스 채움
    canvas.drawRRect(rrect, Paint()..color = AppColor.tilePath);

    // 보라빛 glow 테두리
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppColor.tilePathGlow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 방향 화살표
    if (pathDirection != null) {
      _renderArrow(canvas, pathDirection!);
    }
  }

  /// 배치 타일: 깊은 남색 베이스 + 미세 테두리
  void _renderPlacement(Canvas canvas) {
    final outerRect = Rect.fromLTWH(0, 0, size.x, size.y);
    final innerRect = outerRect.deflate(_padding);
    final rrect = RRect.fromRectAndRadius(innerRect, const Radius.circular(_radius));

    // 베이스 채움 (점유 여부에 따라 색상 변경)
    final baseColor = occupant != null
        ? AppColor.tilePlacementOccupied
        : AppColor.tilePlacementEmpty;
    canvas.drawRRect(rrect, Paint()..color = baseColor);

    // 테두리: 캐릭터가 있으면 등급 색상, 없으면 기본
    final borderColor = occupant != null
        ? AppColor.gradeColor(occupant!.data.grade)
        : AppColor.tilePlacementBorder;
    final borderWidth = occupant != null ? 1.5 : 0.5;
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth,
    );
  }

  /// 스폰 타일: 보라색 베이스 + 원형 글로우 마커
  void _renderSpawn(Canvas canvas) {
    final outerRect = Rect.fromLTWH(0, 0, size.x, size.y);
    final innerRect = outerRect.deflate(_padding);
    final rrect = RRect.fromRectAndRadius(innerRect, const Radius.circular(_radius));

    // 보라색 베이스
    canvas.drawRRect(rrect, Paint()..color = AppColor.tileSpawn);

    // glow 테두리
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppColor.tilePathGlow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 원형 글로우 마커
    final center = Offset(size.x / 2, size.y / 2);
    final outerRadius = min(size.x, size.y) * 0.28;
    final innerRadius = outerRadius * 0.55;

    // 바깥 원 (반투명 glow)
    canvas.drawCircle(
      center,
      outerRadius,
      Paint()..color = AppColor.tileSpawnGlow.withValues(alpha: 0.3),
    );

    // 안쪽 원 (solid)
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()..color = AppColor.tileSpawnGlow.withValues(alpha: 0.8),
    );
  }

  /// 차단 타일: 거의 검정 베이스
  void _renderBlocked(Canvas canvas) {
    final outerRect = Rect.fromLTWH(0, 0, size.x, size.y);
    final innerRect = outerRect.deflate(_padding);
    final rrect = RRect.fromRectAndRadius(innerRect, const Radius.circular(_radius));

    canvas.drawRRect(rrect, Paint()..color = AppColor.tileBlocked);

    // 어두운 보라 테두리
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = AppColor.tileBorder
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5,
    );
  }

  /// 방향 화살표 렌더링 (반투명 보라 삼각형)
  void _renderArrow(Canvas canvas, PathDirection direction) {
    final cx = size.x / 2;
    final cy = size.y / 2;
    final arrowSize = min(size.x, size.y) * 0.2;

    final paint = Paint()..color = AppColor.tilePathGlow.withValues(alpha: 0.45);
    final path = Path();

    switch (direction) {
      case PathDirection.right:
        path.moveTo(cx + arrowSize, cy);
        path.lineTo(cx - arrowSize * 0.5, cy - arrowSize * 0.6);
        path.lineTo(cx - arrowSize * 0.5, cy + arrowSize * 0.6);
      case PathDirection.left:
        path.moveTo(cx - arrowSize, cy);
        path.lineTo(cx + arrowSize * 0.5, cy - arrowSize * 0.6);
        path.lineTo(cx + arrowSize * 0.5, cy + arrowSize * 0.6);
      case PathDirection.down:
        path.moveTo(cx, cy + arrowSize);
        path.lineTo(cx - arrowSize * 0.6, cy - arrowSize * 0.5);
        path.lineTo(cx + arrowSize * 0.6, cy - arrowSize * 0.5);
    }

    path.close();
    canvas.drawPath(path, paint);
  }
}
