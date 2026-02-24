import 'dart:math';

import 'package:flame/game.dart';

import 'const/asset/app_character_path.dart';
import 'game_state.dart';
import '../data/definitions/character_defs.dart';
import '../data/models/character_model.dart';
import '../data/models/effect_model.dart';
import '../data/models/recipe_model.dart';
import '../data/models/reward_model.dart';
import '../gameplay/components/character.dart';
import '../gameplay/components/enemy.dart';
import '../gameplay/components/projectile.dart';
import '../gameplay/components/wave_countdown.dart';
import '../gameplay/map/grid_map.dart';
import '../gameplay/systems/boss_summon_system.dart';
import '../gameplay/systems/combine_system.dart';
import '../gameplay/systems/economy_system.dart';
import '../gameplay/systems/gacha_system.dart';
import '../gameplay/systems/mission_system.dart';
import '../gameplay/systems/reward_system.dart';
import '../gameplay/systems/synergy_system.dart';
import '../gameplay/systems/upgrade_system.dart';
import '../gameplay/systems/wave_system.dart';

/// 메인 FlameGame 클래스
class EmotionDefenseGame extends FlameGame {
  late GameState gameState;
  late GridMap gridMap;
  late WaveSystem waveSystem;
  late EconomySystem economySystem;
  late GachaSystem gachaSystem;
  late CombineSystem combineSystem;
  late UpgradeSystem upgradeSystem;
  late RewardSystem rewardSystem;
  late MissionSystem missionSystem;
  late BossSummonSystem bossSummonSystem;
  static const SynergySystem synergySystem = SynergySystem();

  /// 시너지 보너스 (매 프레임 재계산)
  SynergyBonuses _synergyBonuses = const SynergyBonuses();
  SynergyBonuses get synergyBonuses => _synergyBonuses;

  /// 배속 (1 = 보통, 2 = 2배)
  int gameSpeed = 1;

  /// 판매 모드 활성 여부
  bool isSellMode = false;

  /// 자동 웨이브 활성 여부 (기본 ON)
  bool isAutoWave = true;

  /// 웨이브 간 대기 타이머 (초)
  double _autoWaveDelay = 3.0;

  /// 자동 웨이브 대기 시간 (초)
  static const double autoWaveInterval = 3.0;

  /// 이전 게임 상태 (웨이브 클리어 감지용)
  GamePhase _previousPhase = GamePhase.preparing;

  /// SafeArea 패딩 (Flutter에서 전달)
  double safeAreaTop = 0;
  double safeAreaBottom = 0;

  /// 웨이브 카운트다운 컴포넌트
  WaveCountdownComponent? _countdownComponent;

  /// 캐릭터 정보 팝업용
  CharacterComponent? selectedCharacter;

  /// 보상 팝업용
  List<RewardOption>? currentRewardOptions;

  /// 미션 체크 타이머 (1초 간격)
  double _missionCheckTimer = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 캐릭터 이미지 프리로드 (중복 경로 제거)
    final allImagePaths = {
      ...commonCharacters.map((c) => c.imagePath),
      ...rareCharacters.map((c) => c.imagePath),
      ...heroCharacters.map((c) => c.imagePath),
      ...legendCharacters.map((c) => c.imagePath),
    };
    for (final path in allImagePaths) {
      await images.load(AppCharacterPath.toFlamePath(path));
    }

    // 게임 상태 초기화
    gameState = GameState();

    // 격자 맵 초기화
    gridMap = GridMap();
    gridMap.initialize(
      size,
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
    );
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

    combineSystem = CombineSystem(gameWorld: this, gridMap: gridMap);

    upgradeSystem = UpgradeSystem(gameState: gameState);
    rewardSystem = RewardSystem();
    missionSystem = MissionSystem(gameState: gameState);
    bossSummonSystem = BossSummonSystem(
      gameState: gameState,
      gameWorld: this,
      tileSize: gridMap.tileSize,
      mapOffset: gridMap.mapOffset,
    );

    // 오버레이 표시
    overlays.add('hud');
    overlays.add('actionBar');
  }

  @override
  void update(double dt) {
    final scaledDt = dt * gameSpeed;
    super.update(scaledDt);

    // 오라 + 시너지 처리 (선두)
    _processAuras();

    // 웨이브 시스템 업데이트 (적 스폰)
    if (gameState.phase == GamePhase.waveActive) {
      waveSystem.update(scaledDt);
    }

    // 웨이브 클리어 감지 → 보너스 골드 지급 + 보상/폭발 체크
    if (_previousPhase == GamePhase.waveActive &&
        gameState.phase == GamePhase.preparing) {
      waveSystem.onWaveClear();
      _autoWaveDelay = autoWaveInterval;

      final clearedWave = gameState.currentWave;

      // 감정 폭발 체크 (5웨이브마다)
      if (clearedWave % 5 == 0 && _synergyBonuses.emotionExplosion) {
        _triggerEmotionExplosion();
      }

      // 보상 팝업 (5웨이브마다)
      if (clearedWave % 5 == 0 && clearedWave > 0) {
        currentRewardOptions = rewardSystem.generateOptions(clearedWave);
        paused = true;
        overlays.add('rewardPopup');
      }
    }

    // 자동 웨이브: preparing 상태에서 카운트다운 후 자동 시작
    if (gameState.phase == GamePhase.preparing &&
        isAutoWave &&
        waveSystem.canStartWave &&
        !overlays.isActive('rewardPopup')) {
      _autoWaveDelay -= scaledDt;

      // 카운트다운 표시
      if (_countdownComponent == null) {
        _countdownComponent = WaveCountdownComponent(
          spawnCenter: gridMap.gridToPixelCenter(0, 0),
          tileSize: gridMap.tileSize,
        );
        add(_countdownComponent!);
      }
      _countdownComponent!.updateFromDelay(_autoWaveDelay);

      if (_autoWaveDelay <= 0) {
        _removeCountdown();
        startWave();
      }
      gameState.notify();
    } else {
      _removeCountdown();
    }

    // 게임오버/승리 오버레이
    if (gameState.phase == GamePhase.gameOver &&
        _previousPhase != GamePhase.gameOver) {
      overlays.add('gameOver');
    }
    if (gameState.phase == GamePhase.victory &&
        _previousPhase != GamePhase.victory) {
      overlays.add('gameOver');
    }

    // 미션 체크 (1초 간격)
    _missionCheckTimer -= scaledDt;
    if (_missionCheckTimer <= 0) {
      _missionCheckTimer = 1.0;
      final characters = children.whereType<CharacterComponent>().toList();
      missionSystem.checkMissions(characters);
    }

    _previousPhase = gameState.phase;
  }

  /// 오라 + 시너지 처리 (매 프레임)
  void _processAuras() {
    final characters = children.whereType<CharacterComponent>().toList();
    final enemies = children.whereType<EnemyComponent>().toList();

    // 시너지 재계산
    _synergyBonuses = synergySystem.calculate(characters);

    // 1. 모든 캐릭터 버프 리셋
    for (final char in characters) {
      char.resetBuffs();
    }

    // 2. 모든 적 오라 디버프 리셋
    for (final enemy in enemies) {
      enemy.resetAuraDebuffs();
    }

    // 3. 시너지 글로벌 버프 적용
    for (final char in characters) {
      char.atkMultiplier +=
          _synergyBonuses.allyAtkBonus + gameState.globalAtkBonus;
      char.aspdMultiplier +=
          _synergyBonuses.allyAspdBonus + gameState.globalAspdBonus;
    }

    // 4. 시너지 글로벌 적 디버프 적용
    for (final enemy in enemies) {
      if (enemy.isDead) continue;
      enemy.auraSpeedMultiplier -= _synergyBonuses.enemySpeedPenalty;
      enemy.auraDefReduction += _synergyBonuses.enemyDefPenalty;
    }

    // 5. 각 캐릭터의 패시브 오라 처리
    for (final char in characters) {
      for (final passive in char.data.passives) {
        final rangePixels =
            (passive.range + _synergyBonuses.bufferRangeBonus) *
            gridMap.tileSize;
        final myCenter = char.position + char.size / 2;

        switch (passive.type) {
          case PassiveType.allyAtkBuff:
            for (final ally in characters) {
              if (ally == char) continue;
              final dist = (ally.position + ally.size / 2 - myCenter).length;
              if (dist <= rangePixels) {
                ally.atkMultiplier += passive.value;
              }
            }
            break;

          case PassiveType.allyAspdBuff:
            for (final ally in characters) {
              if (ally == char) continue;
              final dist = (ally.position + ally.size / 2 - myCenter).length;
              if (dist <= rangePixels) {
                ally.aspdMultiplier += passive.value;
              }
            }
            break;

          case PassiveType.enemySpdDebuff:
            for (final enemy in enemies) {
              if (enemy.isDead) continue;
              final dist = (enemy.center - myCenter).length;
              if (dist <= rangePixels) {
                enemy.auraSpeedMultiplier -= passive.value;
              }
            }
            break;

          case PassiveType.enemyDefDebuff:
            for (final enemy in enemies) {
              if (enemy.isDead) continue;
              final dist = (enemy.center - myCenter).length;
              if (dist <= rangePixels) {
                enemy.auraDefReduction += passive.value;
              }
            }
            break;
        }
      }
    }

    // 6. 시너지 보너스를 투사체에 전달
    final projectiles = children.whereType<ProjectileComponent>().toList();
    for (final proj in projectiles) {
      proj.extraCritBonus = _synergyBonuses.dealerCritBonus;
      proj.extraStunDuration = _synergyBonuses.stunDurationBonus;
      proj.extraDebufferDuration = _synergyBonuses.debufferDurationBonus;
    }
  }

  /// 감정 폭발 — 전체 적에게 100 고정 데미지
  void _triggerEmotionExplosion() {
    final enemies = children.whereType<EnemyComponent>().toList();
    for (final enemy in enemies) {
      if (!enemy.isDead) {
        enemy.takeDamage(100);
      }
    }
  }

  /// 자동 웨이브 남은 시간 (초)
  double get autoWaveRemaining => _autoWaveDelay.clamp(0.0, autoWaveInterval);

  /// 카운트다운 컴포넌트 제거
  void _removeCountdown() {
    _countdownComponent?.removeFromParent();
    _countdownComponent = null;
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
    gameState.totalCombineCount++;
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

  /// 일반 캐릭터 교체 — 10G 소비 → 다른 랜덤 일반 캐릭터로 교체
  void doReroll() {
    const cost = 10;
    final char = selectedCharacter;
    if (char == null || char.data.grade != Grade.common) return;
    if (!gameState.spendGold(cost)) return;

    // 현재 캐릭터와 다른 일반 캐릭터 선택
    final candidates =
        commonCharacters.where((c) => c.id != char.data.id).toList();
    final newData = candidates[Random().nextInt(candidates.length)];

    // 같은 타일에 새 캐릭터 생성
    final tile = char.currentTile;
    char.removeCharacter();

    final newChar = CharacterComponent(
      data: newData,
      currentTile: tile,
      gridMap: gridMap,
    );
    add(newChar);

    // 팝업을 새 캐릭터로 갱신
    selectedCharacter = newChar;
    gameState.notify();
  }

  /// 캐릭터 정보 팝업 표시
  void showCharacterInfo(CharacterComponent char) {
    selectedCharacter = char;
    overlays.add('characterInfo');
    gameState.notify();
  }

  /// 캐릭터 정보 팝업 닫기
  void hideCharacterInfo() {
    selectedCharacter = null;
    overlays.remove('characterInfo');
    gameState.notify();
  }

  /// ATK 강화 (등급별)
  void doUpgradeAtk(Grade grade) {
    upgradeSystem.upgradeAtk(grade);
    gameState.notify();
  }

  /// ASPD 강화 (등급별)
  void doUpgradeAspd(Grade grade) {
    upgradeSystem.upgradeAspd(grade);
    gameState.notify();
  }

  /// 강화 팝업 토글
  void toggleUpgradePopup() {
    if (overlays.isActive('upgradePopup')) {
      overlays.remove('upgradePopup');
    } else {
      overlays.add('upgradePopup');
    }
  }

  /// 보상 선택
  void selectReward(RewardOption option) {
    switch (option.type) {
      case RewardType.bonusGold:
        gameState.addGold(option.value);
        break;
      case RewardType.randomRare:
        gachaSystem.spawnCharacter(rareCharacters);
        break;
      case RewardType.randomHero:
        gachaSystem.spawnCharacter(heroCharacters);
        break;
      case RewardType.globalAtkBuff:
        gameState.globalAtkBonus += option.value / 100.0;
        break;
      case RewardType.globalAspdBuff:
        gameState.globalAspdBonus += option.value / 100.0;
        break;
      case RewardType.gachaCostDiscount:
        gameState.gachaCostDiscount += option.value;
        break;
      case RewardType.enemyLimitIncrease:
        gameState.maxAliveEnemiesBonus += option.value;
        break;
    }

    currentRewardOptions = null;
    overlays.remove('rewardPopup');
    paused = false;
    _autoWaveDelay = autoWaveInterval;
    gameState.notify();
  }

  /// 배속 토글 (1x → 2x → 1x)
  void toggleSpeed() {
    gameSpeed = gameSpeed == 1 ? 2 : 1;
    gameState.notify();
  }

  /// 일시정지 토글
  void togglePause() {
    paused = !paused;
    if (paused) {
      overlays.add('pausePopup');
    } else {
      overlays.remove('pausePopup');
    }
  }

  /// 퀘스트 팝업 토글
  void toggleQuestPopup() {
    if (overlays.isActive('questPopup')) {
      overlays.remove('questPopup');
    } else {
      overlays.add('questPopup');
    }
  }

  /// 미션 보상 수령
  void claimMissionReward(String missionId) {
    missionSystem.claimReward(missionId);
  }

  /// 보스 소환
  void doSummonBoss() {
    bossSummonSystem.summon();
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
    gridMap.initialize(
      size,
      safeAreaTop: safeAreaTop,
      safeAreaBottom: safeAreaBottom,
    );
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

    combineSystem = CombineSystem(gameWorld: this, gridMap: gridMap);

    upgradeSystem = UpgradeSystem(gameState: gameState);
    missionSystem = MissionSystem(gameState: gameState);
    bossSummonSystem = BossSummonSystem(
      gameState: gameState,
      gameWorld: this,
      tileSize: gridMap.tileSize,
      mapOffset: gridMap.mapOffset,
    );

    isSellMode = false;
    isAutoWave = true;
    gameSpeed = 1;
    _autoWaveDelay = autoWaveInterval;
    _previousPhase = GamePhase.preparing;
    _synergyBonuses = const SynergyBonuses();
    _missionCheckTimer = 0;
    _countdownComponent = null;
    selectedCharacter = null;
    currentRewardOptions = null;
    paused = false;
    overlays.remove('gameOver');
    overlays.remove('combinePopup');
    overlays.remove('pausePopup');
    overlays.remove('characterInfo');
    overlays.remove('rewardPopup');
    overlays.remove('upgradePopup');
    overlays.remove('questPopup');
  }
}
