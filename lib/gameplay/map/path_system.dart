import 'dart:math';
import 'dart:ui';

import '../../core/constants.dart';

/// 타일 종류
enum TileType {
  path, // 적 이동 경로
  placement, // 캐릭터 배치 가능
  spawn, // 적 스폰 지점 (경로의 일부)
  blocked, // 배치 불가 (장식)
}

/// 6x10 맵 레이아웃 정의
/// 외곽 순환 루프 — 적이 사각형 외곽을 따라 계속 도는 구조
///
/// [S] [→] [→] [→] [→] [↓]   row 0
/// [↑] [□] [□] [□] [□] [↓]   row 1
/// [↑] [□] [□] [□] [□] [↓]   row 2
/// [↑] [□] [□] [□] [□] [↓]   row 3
/// [↑] [□] [□] [□] [□] [↓]   row 4
/// [↑] [□] [□] [□] [□] [↓]   row 5
/// [↑] [□] [□] [□] [□] [↓]   row 6
/// [↑] [□] [□] [□] [□] [↓]   row 7
/// [↑] [□] [□] [□] [□] [↓]   row 8
/// [↑] [←] [←] [←] [←] [←]   row 9
///
/// 경로 28칸, 배치 32칸
/// 적은 외곽을 무한히 순환하며, 살아있는 적이 한도 이상이면 게임오버
class PathSystem {
  PathSystem._();

  /// 맵 레이아웃 (row, col) - 6열 x 10행
  static final List<List<TileType>> mapLayout = [
    // row 0: [S] [→] [→] [→] [→] [↓]
    [TileType.spawn, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
    // row 1~8: [↑] [□] [□] [□] [□] [↓]
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 9: [↑] [←] [←] [←] [←] [←]
    [TileType.path, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
  ];

  /// 적 이동 웨이포인트 (격자 좌표 [row, col] 순서)
  /// 시계방향 순환 루프 — 마지막 다음은 첫 번째로 돌아감
  static final List<Point<int>> waypoints = [
    // 상단 (오른쪽으로)
    const Point(0, 0), // spawn
    const Point(0, 1),
    const Point(0, 2),
    const Point(0, 3),
    const Point(0, 4),
    const Point(0, 5),
    // 오른쪽 (아래로)
    const Point(1, 5),
    const Point(2, 5),
    const Point(3, 5),
    const Point(4, 5),
    const Point(5, 5),
    const Point(6, 5),
    const Point(7, 5),
    const Point(8, 5),
    // 하단 (왼쪽으로)
    const Point(9, 5),
    const Point(9, 4),
    const Point(9, 3),
    const Point(9, 2),
    const Point(9, 1),
    const Point(9, 0),
    // 왼쪽 (위로) — 루프 복귀
    const Point(8, 0),
    const Point(7, 0),
    const Point(6, 0),
    const Point(5, 0),
    const Point(4, 0),
    const Point(3, 0),
    const Point(2, 0),
    const Point(1, 0),
    // → 다시 (0,0)으로 순환
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
