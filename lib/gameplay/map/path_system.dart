import 'dart:math';
import 'dart:ui';

import '../../core/constants.dart';

/// 타일 종류
enum TileType {
  path, // 적 이동 경로
  placement, // 캐릭터 배치 가능
  spawn, // 적 스폰 지점
  end, // 적 도달 지점
  blocked, // 배치 불가 (장식)
}

/// 6x10 맵 레이아웃 정의
/// 기획서의 회전 경로 레이아웃을 기반으로 구성
class PathSystem {
  PathSystem._();

  /// 맵 레이아웃 (row, col) - 6열 x 10행
  /// S=spawn, E=end, P=path, O=placement, X=blocked
  static final List<List<TileType>> mapLayout = [
    // row 0: [S] [X] [O] [O] [O] [O]
    [TileType.spawn, TileType.blocked, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
    // row 1: [↓] [X] [O] [O] [O] [O]
    [TileType.path, TileType.blocked, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
    // row 2: [→] [→] [→] [↓] [O] [O]
    [TileType.path, TileType.path, TileType.path, TileType.path, TileType.placement, TileType.placement],
    // row 3: [O] [O] [O] [↓] [O] [O]
    [TileType.placement, TileType.placement, TileType.placement, TileType.path, TileType.placement, TileType.placement],
    // row 4: [O] [O] [O] [→] [→] [↓]
    [TileType.placement, TileType.placement, TileType.placement, TileType.path, TileType.path, TileType.path],
    // row 5: [O] [O] [O] [O] [O] [↓]
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 6: [O] [↑] [←] [←] [←] [←]
    [TileType.placement, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
    // row 7: [O] [↑] [O] [O] [O] [O]
    [TileType.placement, TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
    // row 8: [O] [→] [→] [→] [→] [E]
    [TileType.placement, TileType.path, TileType.path, TileType.path, TileType.path, TileType.end],
    // row 9: [O] [O] [O] [O] [O] [O]
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
  ];

  /// 적 이동 웨이포인트 (격자 좌표 [row, col] 순서)
  /// 스폰 → 경로 → 종료 순서
  static final List<Point<int>> waypoints = [
    const Point(0, 0),  // spawn
    const Point(1, 0),
    const Point(2, 0),
    const Point(2, 1),
    const Point(2, 2),
    const Point(2, 3),
    const Point(3, 3),
    const Point(4, 3),
    const Point(4, 4),
    const Point(4, 5),
    const Point(5, 5),
    const Point(6, 5),
    const Point(6, 4),
    const Point(6, 3),
    const Point(6, 2),
    const Point(6, 1),
    const Point(7, 1),
    const Point(8, 1),
    const Point(8, 2),
    const Point(8, 3),
    const Point(8, 4),
    const Point(8, 5),  // end
  ];

  /// 격자 좌표를 픽셀 좌표(타일 중심)로 변환
  static Offset gridToPixel(int row, int col, double tileSize, Offset mapOffset) {
    return Offset(
      mapOffset.dx + col * tileSize + tileSize / 2,
      mapOffset.dy + row * tileSize + tileSize / 2,
    );
  }

  /// 웨이포인트를 픽셀 좌표 리스트로 변환
  static List<Offset> waypointsToPixels(double tileSize, Offset mapOffset) {
    return waypoints.map((p) => gridToPixel(p.x, p.y, tileSize, mapOffset)).toList();
  }

  /// 타일 타입 조회
  static TileType getTileType(int row, int col) {
    if (row < 0 || row >= GameConstants.gridRows ||
        col < 0 || col >= GameConstants.gridColumns) {
      return TileType.blocked;
    }
    return mapLayout[row][col];
  }
}
