import 'package:flame/game.dart';

import 'game_state.dart';
import '../data/models/recipe_model.dart';
import '../gameplay/components/character.dart';
import '../gameplay/map/grid_map.dart';
import '../gameplay/systems/combine_system.dart';
import '../gameplay/systems/economy_system.dart';
import '../gameplay/systems/gacha_system.dart';
import '../gameplay/systems/wave_system.dart';

/// 메인 FlameGame 클래스
class EmotionDefenseGame extends FlameGame {
  late GameState gameState;
  late GridMap gridMap;
  late WaveSystem waveSystem;
  late EconomySystem economySystem;
  late GachaSystem gachaSystem;
  late CombineSystem combineSystem;

  /// 판매 모드 활성 여부
  bool isSellMode = false;

  /// 이전 게임 상태 (웨이브 클리어 감지용)
  GamePhase _previousPhase = GamePhase.preparing;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 게임 상태 초기화
    gameState = GameState();

    // 격자 맵 초기화
    gridMap = GridMap();
    gridMap.initialize(size);
    add(gridMap);

    // 시스템 초기화
    economySystem = EconomySystem(gameState: gameState);

    waveSystem = WaveSystem(
      gameState: gameState,
      gameWorld: this,
      tileSize: gridMap.tileSize,
      mapOffset: gridMap.mapOffset,
    );

    gachaSystem = GachaSystem(
      gameState: gameState,
      gridMap: gridMap,
      gameWorld: this,
    );

    combineSystem = CombineSystem(
      gameWorld: this,
      gridMap: gridMap,
    );

    // 오버레이 표시
    overlays.add('hud');
    overlays.add('actionBar');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // 웨이브 시스템 업데이트 (적 스폰)
    if (gameState.phase == GamePhase.waveActive) {
      waveSystem.update(dt);
    }

    // 웨이브 클리어 감지 → 보너스 골드 지급
    if (_previousPhase == GamePhase.waveActive &&
        gameState.phase == GamePhase.preparing) {
      waveSystem.onWaveClear();
    }

    // 게임오버/승리 오버레이
    if (gameState.phase == GamePhase.gameOver &&
        _previousPhase != GamePhase.gameOver) {
      overlays.add('gameOver');
    }
    if (gameState.phase == GamePhase.victory &&
        _previousPhase != GamePhase.victory) {
      overlays.add('gameOver'); // 승리도 같은 오버레이 사용
    }

    _previousPhase = gameState.phase;
  }

  /// 뽑기 실행
  void doGacha() {
    gachaSystem.execute();
  }

  /// 웨이브 시작
  void startWave() {
    if (gameState.phase == GamePhase.preparing && waveSystem.canStartWave) {
      waveSystem.startWave();
    }
  }

  /// 조합 실행
  void doCombine(RecipeData recipe) {
    combineSystem.execute(recipe);
    gameState.notify();
  }

  /// 판매 모드 토글
  void toggleSellMode() {
    isSellMode = !isSellMode;
    gameState.notify();
  }

  /// 캐릭터 판매 — sellValue 만큼 골드 환급
  void doSell(CharacterComponent char) {
    gameState.addGold(char.data.sellValue);
    char.removeCharacter();
    gameState.notify();
  }

  /// 조합표 팝업 토글
  void toggleCombinePopup() {
    if (overlays.isActive('combinePopup')) {
      overlays.remove('combinePopup');
    } else {
      overlays.add('combinePopup');
    }
  }

  /// 게임 리셋 (새 게임)
  void resetGame() {
    // 모든 적, 캐릭터, 투사체 제거
    children.whereType<GridMap>().forEach((g) => g.removeFromParent());

    // 게임에 추가된 적/캐릭터/투사체 제거
    removeWhere((component) => component is! GridMap);

    gameState.reset();

    // 맵 재생성
    gridMap = GridMap();
    gridMap.initialize(size);
    add(gridMap);

    // 시스템 재초기화
    waveSystem = WaveSystem(
      gameState: gameState,
      gameWorld: this,
      tileSize: gridMap.tileSize,
      mapOffset: gridMap.mapOffset,
    );

    gachaSystem = GachaSystem(
      gameState: gameState,
      gridMap: gridMap,
      gameWorld: this,
    );

    combineSystem = CombineSystem(
      gameWorld: this,
      gridMap: gridMap,
    );

    isSellMode = false;
    _previousPhase = GamePhase.preparing;
    overlays.remove('gameOver');
    overlays.remove('combinePopup');
  }
}
