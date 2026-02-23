import '../../data/models/wave_model.dart';

/// 웨이브 1~10 정의 (Phase 1)
/// HP는 웨이브당 +15% 스케일링 (기본 HP에 hpMultiplier 적용)
final List<WaveData> allWaves = [
  const WaveData(
    wave: 1,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 5, delay: 1.5)],
    clearGold: 20,
    autoGold: 10,
  ),
  const WaveData(
    wave: 2,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 7, delay: 1.3)],
    clearGold: 25,
    autoGold: 10,
  ),
  const WaveData(
    wave: 3,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 9, delay: 1.2)],
    clearGold: 30,
    autoGold: 15,
  ),
  const WaveData(
    wave: 4,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 10, delay: 1.1)],
    clearGold: 30,
    autoGold: 15,
  ),
  const WaveData(
    wave: 5,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 12, delay: 1.0)],
    clearGold: 40,
    autoGold: 20,
  ),
  const WaveData(
    wave: 6,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 13, delay: 1.0)],
    clearGold: 40,
    autoGold: 20,
  ),
  const WaveData(
    wave: 7,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 15, delay: 0.9)],
    clearGold: 45,
    autoGold: 20,
  ),
  const WaveData(
    wave: 8,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 16, delay: 0.9)],
    clearGold: 45,
    autoGold: 25,
  ),
  const WaveData(
    wave: 9,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 18, delay: 0.8)],
    clearGold: 50,
    autoGold: 25,
  ),
  const WaveData(
    wave: 10,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 20, delay: 0.8)],
    clearGold: 60,
    autoGold: 30,
  ),
];

/// 웨이브별 HP 스케일링 배율 (웨이브당 +15%)
double hpMultiplier(int wave) => 1.0 * _pow(1.15, wave - 1);

double _pow(double base, int exp) {
  double result = 1.0;
  for (int i = 0; i < exp; i++) {
    result *= base;
  }
  return result;
}
