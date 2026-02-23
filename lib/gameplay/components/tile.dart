import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../map/path_system.dart';
import 'character.dart';

/// 격자 맵의 개별 타일 컴포넌트
class TileComponent extends PositionComponent {
  final int row;
  final int col;
  final TileType tileType;

  /// 이 타일에 배치된 캐릭터 (없으면 null)
  CharacterComponent? occupant;

  TileComponent({
    required this.row,
    required this.col,
    required this.tileType,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  /// 캐릭터 배치 가능 여부
  bool get canPlace => tileType == TileType.placement && occupant == null;

  /// 타일 타입에 따른 색상
  Color get _color {
    switch (tileType) {
      case TileType.path:
        return AppColor.tilePath;
      case TileType.placement:
        return occupant != null
            ? AppColor.tilePlacementOccupied
            : AppColor.tilePlacementEmpty;
      case TileType.spawn:
        return AppColor.tileSpawn;
      case TileType.end:
        return AppColor.tileEnd;
      case TileType.blocked:
        return AppColor.tileBlocked;
    }
  }

  @override
  void render(Canvas canvas) {
    // 타일 배경
    final paint = Paint()..color = _color;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      paint,
    );

    // 타일 테두리
    final borderPaint = Paint()
      ..color = AppColor.tileBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      borderPaint,
    );

    // 스폰/종료 마커
    if (tileType == TileType.spawn || tileType == TileType.end) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: tileType == TileType.spawn ? 'S' : 'E',
          style: AppTextStyle.tileMarker,
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          (size.x - textPainter.width) / 2,
          (size.y - textPainter.height) / 2,
        ),
      );
    }
  }
}
