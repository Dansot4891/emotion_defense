import 'dart:math';

import 'package:flame/components.dart';

import '../../core/constants.dart';
import '../../core/game_state.dart';
import '../../data/definitions/character_defs.dart';
import '../components/character.dart';
import '../map/grid_map.dart';

/// 뽑기 시스템 - 30G 소모 → 랜덤 일반 캐릭터 → 빈 타일에 배치
class GachaSystem {
  final GameState gameState;
  final GridMap gridMap;
  final Component gameWorld; // 캐릭터를 추가할 부모 컴포넌트
  final Random _random = Random();

  GachaSystem({
    required this.gameState,
    required this.gridMap,
    required this.gameWorld,
  });

  /// 뽑기 가능 여부
  bool get canGacha {
    return gameState.gold >= GameConstants.gachaCost &&
        gridMap.getEmptyPlacementTiles().isNotEmpty;
  }

  /// 뽑기 실행
  CharacterComponent? execute() {
    if (!canGacha) return null;

    // 골드 소모
    if (!gameState.spendGold(GameConstants.gachaCost)) return null;

    // 랜덤 일반 캐릭터 선택
    final charData = commonCharacters[_random.nextInt(commonCharacters.length)];

    // 빈 타일에 배치
    final emptyTiles = gridMap.getEmptyPlacementTiles();
    if (emptyTiles.isEmpty) return null;
    final tile = emptyTiles[_random.nextInt(emptyTiles.length)];

    // 캐릭터 생성 및 배치
    final character = CharacterComponent(
      data: charData,
      currentTile: tile,
      gridMap: gridMap,
    );
    gameWorld.add(character);
    return character;
  }
}
