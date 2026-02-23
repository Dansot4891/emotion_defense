import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/constants.dart';
import '../components/tile.dart';
import 'path_system.dart';

/// 격자 맵 컴포넌트 - 타일 생성/관리
class GridMap extends PositionComponent {
  late double tileSize;
  late Offset mapOffset;
  late List<List<TileComponent>> tiles;

  /// 화면 크기 기반 맵 초기화
  void initialize(Vector2 screenSize) {
    // HUD와 액션바 높이를 제외한 가용 영역 계산
    final availableWidth = screenSize.x;
    final availableHeight =
        screenSize.y - GameConstants.hudHeight - GameConstants.actionBarHeight;

    // 격자에 맞춰 tileSize 동적 계산
    final tileSizeByWidth = availableWidth / GameConstants.gridColumns;
    final tileSizeByHeight = availableHeight / GameConstants.gridRows;
    tileSize = tileSizeByWidth < tileSizeByHeight
        ? tileSizeByWidth
        : tileSizeByHeight;

    // 맵을 가용 영역 중앙에 배치
    final mapWidth = tileSize * GameConstants.gridColumns;
    final mapHeight = tileSize * GameConstants.gridRows;
    mapOffset = Offset(
      (screenSize.x - mapWidth) / 2,
      GameConstants.hudHeight + (availableHeight - mapHeight) / 2,
    );

    // 타일 생성
    tiles = List.generate(GameConstants.gridRows, (row) {
      return List.generate(GameConstants.gridColumns, (col) {
        final tileType = PathSystem.getTileType(row, col);
        final tile = TileComponent(
          row: row,
          col: col,
          tileType: tileType,
          position: Vector2(
            mapOffset.dx + col * tileSize,
            mapOffset.dy + row * tileSize,
          ),
          size: Vector2(tileSize, tileSize),
        );
        add(tile);
        return tile;
      });
    });
  }

  /// 특정 격자 좌표의 타일 반환
  TileComponent? getTile(int row, int col) {
    if (row < 0 || row >= GameConstants.gridRows ||
        col < 0 || col >= GameConstants.gridColumns) {
      return null;
    }
    return tiles[row][col];
  }

  /// 빈 배치 가능 타일 목록
  List<TileComponent> getEmptyPlacementTiles() {
    final result = <TileComponent>[];
    for (final row in tiles) {
      for (final tile in row) {
        if (tile.canPlace) {
          result.add(tile);
        }
      }
    }
    return result;
  }

  /// 픽셀 좌표에서 타일 찾기
  TileComponent? getTileAtPixel(double x, double y) {
    final col = ((x - mapOffset.dx) / tileSize).floor();
    final row = ((y - mapOffset.dy) / tileSize).floor();
    return getTile(row, col);
  }

  /// 격자 좌표를 픽셀 중심 좌표로 변환
  Vector2 gridToPixelCenter(int row, int col) {
    return Vector2(
      mapOffset.dx + col * tileSize + tileSize / 2,
      mapOffset.dy + row * tileSize + tileSize / 2,
    );
  }
}
