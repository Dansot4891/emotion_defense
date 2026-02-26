import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/game_state.dart';
import '../../core/sound_manager.dart';
import '../../data/definitions/enemy_defs.dart';
import '../../data/definitions/wave_defs.dart';
import '../../data/models/wave_model.dart';
import '../components/enemy.dart';
import '../map/path_system.dart';

/// 웨이브 시스템 - 웨이브 시작/적 스폰 타이머/웨이브 클리어 판정
class WaveSystem {
  final GameState gameState;
  final Component gameWorld; // 적을 추가할 부모 컴포넌트
  final double tileSize;
  final Offset mapOffset;

  late List<Offset> _pixelWaypoints;

  // 스폰 상태
  WaveData? _currentWaveData;
  int _spawnGroupIndex = 0;
  int _spawnedInGroup = 0;
  double _spawnTimer = 0;
  bool _isSpawning = false;

  WaveSystem({
    required this.gameState,
    required this.gameWorld,
    required this.tileSize,
    required this.mapOffset,
  }) {
    _pixelWaypoints = PathSystem.waypointsToPixels(tileSize, mapOffset);
  }

  /// 다음 웨이브 번호
  int get nextWave => gameState.currentWave + 1;

  /// 시작 가능한 웨이브가 있는지
  bool get canStartWave => nextWave <= allWaves.length;

  /// 웨이브 시작
  void startWave() {
    if (!canStartWave) return;

    final waveIndex = nextWave - 1;
    _currentWaveData = allWaves[waveIndex];

    // 총 적 수 계산
    int totalEnemies = 0;
    for (final spawn in _currentWaveData!.enemies) {
      totalEnemies += spawn.count;
    }

    // 자동 골드 지급
    gameState.addGold(_currentWaveData!.autoGold);

    // 웨이브 시작
    gameState.startWave(nextWave, totalEnemies);
    _spawnGroupIndex = 0;
    _spawnedInGroup = 0;
    _spawnTimer = 0;
    _isSpawning = true;
  }

  /// 매 프레임 업데이트 - 적 스폰 관리
  void update(double dt) {
    if (!_isSpawning || _currentWaveData == null) return;

    _spawnTimer -= dt;
    if (_spawnTimer > 0) return;

    // 현재 스폰 그룹
    if (_spawnGroupIndex >= _currentWaveData!.enemies.length) {
      _isSpawning = false;
      return;
    }

    final spawnGroup = _currentWaveData!.enemies[_spawnGroupIndex];

    // 적 스폰
    _spawnEnemy(spawnGroup.enemyId);
    _spawnedInGroup++;

    if (_spawnedInGroup >= spawnGroup.count) {
      // 다음 스폰 그룹
      _spawnGroupIndex++;
      _spawnedInGroup = 0;
    }

    _spawnTimer = spawnGroup.delay;
  }

  /// 적 하나 스폰
  void _spawnEnemy(String enemyId) {
    final enemyData = getEnemyData(enemyId);
    final multiplier = hpMultiplier(gameState.currentWave);

    final enemy = EnemyComponent(
      data: enemyData,
      pixelWaypoints: _pixelWaypoints,
      gameState: gameState,
      hpMultiplier: multiplier,
      wave: gameState.currentWave,
      tileSize: tileSize,
    );
    gameWorld.add(enemy);
    gameState.onEnemySpawned();

    // 보스 등장 사운드
    if (enemyData.isBoss) {
      SoundManager.instance.play(Sfx.bossSpawn);
    }
  }

  /// 웨이브 클리어 보너스 골드 지급 (GameState에서 preparing으로 전환될 때 호출)
  void onWaveClear() {
    if (_currentWaveData != null) {
      gameState.addGold(_currentWaveData!.clearGold);
    }
  }
}
