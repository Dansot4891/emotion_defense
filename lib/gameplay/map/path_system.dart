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
/// S자형 경로 — 적이 좌우로 왕복하며 아래로 내려가는 구조
///
/// [S] [→] [→] [→] [→] [↓]   row 0: 경로 (6)
/// [□] [□] [□] [□] [□] [↓]   row 1: 배치 5 + 경로 1
/// [□] [□] [□] [□] [□] [↓]   row 2: 배치 5 + 경로 1
/// [←] [←] [←] [←] [←] [←]   row 3: 경로 (6)
/// [↓] [□] [□] [□] [□] [□]   row 4: 경로 1 + 배치 5
/// [↓] [□] [□] [□] [□] [□]   row 5: 경로 1 + 배치 5
/// [→] [→] [→] [→] [→] [→]   row 6: 경로 (6)
/// [□] [□] [□] [□] [□] [↓]   row 7: 배치 5 + 경로 1
/// [□] [□] [□] [□] [□] [↓]   row 8: 배치 5 + 경로 1
/// [←] [←] [←] [←] [←] [←]   row 9: 경로 (6)
///
/// 경로 30칸, 배치 30칸
/// 모든 배치 타일이 경로에서 1~2칸 이내 → range 2 캐릭터도 공격 가능
/// 적은 (9,0)에서 (0,0)으로 순환
class PathSystem {
  PathSystem._();

  /// 맵 레이아웃 (row, col) - 6열 x 10행
  static final List<List<TileType>> mapLayout = [
    // row 0: [S] [→] [→] [→] [→] [↓] — 경로
    [TileType.spawn, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
    // row 1: [□] [□] [□] [□] [□] [↓] — 배치 5 + 경로 1
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 2: [□] [□] [□] [□] [□] [↓] — 배치 5 + 경로 1
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 3: [←] [←] [←] [←] [←] [←] — 경로
    [TileType.path, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
    // row 4: [↓] [□] [□] [□] [□] [□] — 경로 1 + 배치 5
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
    // row 5: [↓] [□] [□] [□] [□] [□] — 경로 1 + 배치 5
    [TileType.path, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement],
    // row 6: [→] [→] [→] [→] [→] [→] — 경로
    [TileType.path, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
    // row 7: [□] [□] [□] [□] [□] [↓] — 배치 5 + 경로 1
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 8: [□] [□] [□] [□] [□] [↓] — 배치 5 + 경로 1
    [TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.placement, TileType.path],
    // row 9: [←] [←] [←] [←] [←] [←] — 경로
    [TileType.path, TileType.path, TileType.path, TileType.path, TileType.path, TileType.path],
  ];

  /// 적 이동 웨이포인트 (격자 좌표 [row, col] 순서)
  /// S자형 순환 — 마지막(9,0) 다음은 첫 번째(0,0)로 돌아감
  static final List<Point<int>> waypoints = [
    // row 0: 오른쪽으로
    const Point(0, 0), // spawn
    const Point(0, 1),
    const Point(0, 2),
    const Point(0, 3),
    const Point(0, 4),
    const Point(0, 5),
    // 아래로
    const Point(1, 5),
    const Point(2, 5),
    // row 3: 왼쪽으로
    const Point(3, 5),
    const Point(3, 4),
    const Point(3, 3),
    const Point(3, 2),
    const Point(3, 1),
    const Point(3, 0),
    // 아래로
    const Point(4, 0),
    const Point(5, 0),
    // row 6: 오른쪽으로
    const Point(6, 0),
    const Point(6, 1),
    const Point(6, 2),
    const Point(6, 3),
    const Point(6, 4),
    const Point(6, 5),
    // 아래로
    const Point(7, 5),
    const Point(8, 5),
    // row 9: 왼쪽으로
    const Point(9, 5),
    const Point(9, 4),
    const Point(9, 3),
    const Point(9, 2),
    const Point(9, 1),
    const Point(9, 0),
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
