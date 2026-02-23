import 'package:flame/components.dart';

import '../../data/definitions/character_defs.dart';
import '../../data/models/recipe_model.dart';
import '../components/character.dart';
import '../map/grid_map.dart';

/// 조합 시스템 — 재료 캐릭터 2개를 소멸시키고 결과 캐릭터 생성
class CombineSystem {
  final Component gameWorld;
  final GridMap gridMap;

  CombineSystem({
    required this.gameWorld,
    required this.gridMap,
  });

  /// 현재 맵에 배치된 캐릭터 ID 목록
  List<String> getOwnedCharacterIds() {
    return gameWorld.children
        .whereType<CharacterComponent>()
        .map((c) => c.data.id)
        .toList();
  }

  /// 레시피 조합 가능 여부 (재료 모두 보유)
  bool canCombine(RecipeData recipe) {
    final owned = getOwnedCharacterIds();
    // 재료별로 하나씩 차감하며 확인 (동일 재료 2개 필요한 경우 대비)
    final remaining = List<String>.from(owned);
    for (final materialId in recipe.materialIds) {
      if (!remaining.remove(materialId)) return false;
    }
    return true;
  }

  /// 매칭되는 재료 CharacterComponent 반환
  List<CharacterComponent> findMaterials(RecipeData recipe) {
    final characters = gameWorld.children
        .whereType<CharacterComponent>()
        .toList();
    final materials = <CharacterComponent>[];
    final used = <CharacterComponent>{};

    for (final materialId in recipe.materialIds) {
      final match = characters.firstWhere(
        (c) => c.data.id == materialId && !used.contains(c),
      );
      materials.add(match);
      used.add(match);
    }
    return materials;
  }

  /// 조합 실행 — 재료 소멸, 결과 캐릭터를 첫 번째 재료 타일에 생성
  CharacterComponent? execute(RecipeData recipe) {
    if (!canCombine(recipe)) return null;

    final resultData = allCharacters[recipe.resultId];
    if (resultData == null) return null;

    final materials = findMaterials(recipe);
    final targetTile = materials.first.currentTile;

    // 재료 캐릭터 제거
    for (final mat in materials) {
      mat.removeCharacter();
    }

    // 결과 캐릭터 생성
    final result = CharacterComponent(
      data: resultData,
      currentTile: targetTile,
      gridMap: gridMap,
    );
    gameWorld.add(result);
    return result;
  }
}
