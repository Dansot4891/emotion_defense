import 'dart:ui';

import 'package:flame/components.dart';

import '../../core/game_state.dart';
import '../../data/definitions/boss_summon_defs.dart';
import '../../data/definitions/wave_defs.dart';
import '../../data/models/enemy_model.dart';
import '../components/enemy.dart';
import '../map/path_system.dart';

/// 보스 소환 시스템 — 무료 소환, 5웨이브 쿨타임
class BossSummonSystem {
  final GameState gameState;
  final Component gameWorld;
  final double tileSize;
  final Offset mapOffset;

  late List<Offset> _pixelWaypoints;

  BossSummonSystem({
    required this.gameState,
    required this.gameWorld,
    required this.tileSize,
    required this.mapOffset,
  }) {
    _pixelWaypoints = PathSystem.waypointsToPixels(tileSize, mapOffset);
  }

  /// 쿨타임 충족 여부
  bool get isCooldownReady =>
      gameState.currentWave - gameState.lastBossSummonWave >=
      bossSummonCooldownWaves;

  /// 다음 소환 가능 웨이브
  int get nextAvailableWave =>
      gameState.lastBossSummonWave + bossSummonCooldownWaves;

  /// 남은 쿨타임 웨이브 수
  int get cooldownRemaining =>
      (nextAvailableWave - gameState.currentWave).clamp(0, bossSummonCooldownWaves);

  /// 소환 가능 여부
  bool get canSummon =>
      gameState.phase != GamePhase.gameOver &&
      gameState.phase != GamePhase.victory &&
      isCooldownReady;

  /// 현재 보상 골드
  int get currentRewardGold =>
      bossSummonRewardGold(gameState.bossSummonCount + 1);

  /// 소환 실행
  void summon() {
    if (!canSummon) return;

    gameState.bossSummonCount++;
    gameState.lastBossSummonWave = gameState.currentWave;

    final count = gameState.bossSummonCount;

    // HP 스케일링: 소환 횟수 + 현재 웨이브 기반
    final wave = gameState.currentWave.clamp(1, 30);
    final hpScale = bossSummonHpScale(count) * hpMultiplier(wave);

    // DEF 스케일링
    final scaledDef = summonedDespair.def + (count - 1);

    // 보상 스케일링
    final scaledReward = bossSummonRewardGold(count);

    // 스케일링된 EnemyData 생성
    final bossData = EnemyData(
      id: summonedDespair.id,
      name: summonedDespair.name,
      hp: summonedDespair.hp,
      def: scaledDef.toDouble(),
      speed: summonedDespair.speed,
      rewardGold: scaledReward,
      color: summonedDespair.color,
      description: summonedDespair.description,
      isBoss: true,
      isSummonedBoss: true,
    );

    final enemy = EnemyComponent(
      data: bossData,
      pixelWaypoints: _pixelWaypoints,
      gameState: gameState,
      hpMultiplier: hpScale,
      wave: gameState.currentWave,
      tileSize: tileSize,
    );

    gameWorld.add(enemy);
    gameState.onSummonedBossSpawned();
  }
}
