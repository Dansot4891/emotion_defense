import '../../data/models/wave_model.dart';

/// 웨이브 1~30 정의
/// HP는 웨이브당 +15% 스케일링 (기본 HP에 hpMultiplier 적용)
final List<WaveData> allWaves = [
  // === Wave 1~4: 잡념만 ===
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

  // === Wave 5~7: 잡념 + 불면 ===
  const WaveData(
    wave: 5,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 8, delay: 1.0),
      EnemySpawn(enemyId: 'insomnia', count: 4, delay: 0.8),
    ],
    clearGold: 40,
    autoGold: 20,
  ),
  const WaveData(
    wave: 6,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 8, delay: 1.0),
      EnemySpawn(enemyId: 'insomnia', count: 5, delay: 0.8),
    ],
    clearGold: 40,
    autoGold: 20,
  ),
  const WaveData(
    wave: 7,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 10, delay: 0.9),
      EnemySpawn(enemyId: 'insomnia', count: 6, delay: 0.7),
    ],
    clearGold: 45,
    autoGold: 20,
  ),

  // === Wave 8~9: 잡념 + 불면 + 무기력 ===
  const WaveData(
    wave: 8,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 8, delay: 0.9),
      EnemySpawn(enemyId: 'insomnia', count: 5, delay: 0.8),
      EnemySpawn(enemyId: 'lethargy', count: 3, delay: 1.5),
    ],
    clearGold: 45,
    autoGold: 25,
  ),
  const WaveData(
    wave: 9,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 10, delay: 0.8),
      EnemySpawn(enemyId: 'insomnia', count: 6, delay: 0.7),
      EnemySpawn(enemyId: 'lethargy', count: 4, delay: 1.3),
    ],
    clearGold: 50,
    autoGold: 25,
  ),

  // === Wave 10: 보스(허무) + 호위 ===
  const WaveData(
    wave: 10,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 8, delay: 0.8),
      EnemySpawn(enemyId: 'insomnia', count: 4, delay: 0.7),
      EnemySpawn(enemyId: 'nihility', count: 1, delay: 2.0),
    ],
    clearGold: 80,
    autoGold: 30,
  ),

  // === Wave 11~14: 불면 + 무기력 증가 ===
  const WaveData(
    wave: 11,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 8, delay: 0.7),
      EnemySpawn(enemyId: 'lethargy', count: 5, delay: 1.2),
    ],
    clearGold: 50,
    autoGold: 25,
  ),
  const WaveData(
    wave: 12,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 8, delay: 0.8),
      EnemySpawn(enemyId: 'insomnia', count: 8, delay: 0.6),
      EnemySpawn(enemyId: 'lethargy', count: 4, delay: 1.2),
    ],
    clearGold: 55,
    autoGold: 25,
  ),
  const WaveData(
    wave: 13,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.6),
      EnemySpawn(enemyId: 'lethargy', count: 6, delay: 1.1),
    ],
    clearGold: 55,
    autoGold: 30,
  ),
  const WaveData(
    wave: 14,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 12, delay: 0.6),
      EnemySpawn(enemyId: 'lethargy', count: 6, delay: 1.0),
    ],
    clearGold: 60,
    autoGold: 30,
  ),

  // === Wave 15~17: 트라우마 등장 ===
  const WaveData(
    wave: 15,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 8, delay: 0.6),
      EnemySpawn(enemyId: 'lethargy', count: 5, delay: 1.0),
      EnemySpawn(enemyId: 'trauma', count: 3, delay: 1.5),
    ],
    clearGold: 70,
    autoGold: 30,
  ),
  const WaveData(
    wave: 16,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 10, delay: 0.7),
      EnemySpawn(enemyId: 'insomnia', count: 8, delay: 0.6),
      EnemySpawn(enemyId: 'trauma', count: 4, delay: 1.3),
    ],
    clearGold: 70,
    autoGold: 30,
  ),
  const WaveData(
    wave: 17,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.5),
      EnemySpawn(enemyId: 'lethargy', count: 5, delay: 1.0),
      EnemySpawn(enemyId: 'trauma', count: 5, delay: 1.2),
    ],
    clearGold: 75,
    autoGold: 35,
  ),

  // === Wave 18~19: 번아웃 등장 ===
  const WaveData(
    wave: 18,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 8, delay: 0.5),
      EnemySpawn(enemyId: 'trauma', count: 4, delay: 1.2),
      EnemySpawn(enemyId: 'burnout', count: 4, delay: 1.0),
    ],
    clearGold: 75,
    autoGold: 35,
  ),
  const WaveData(
    wave: 19,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.5),
      EnemySpawn(enemyId: 'lethargy', count: 5, delay: 1.0),
      EnemySpawn(enemyId: 'burnout', count: 5, delay: 0.9),
    ],
    clearGold: 80,
    autoGold: 35,
  ),

  // === Wave 20: 보스 + 트라우마 호위 ===
  const WaveData(
    wave: 20,
    enemies: [
      EnemySpawn(enemyId: 'trauma', count: 5, delay: 1.0),
      EnemySpawn(enemyId: 'lethargy', count: 4, delay: 1.0),
      EnemySpawn(enemyId: 'nihility', count: 1, delay: 2.0),
    ],
    clearGold: 100,
    autoGold: 40,
  ),

  // === Wave 21~29: 전 적 혼합, 대량 스폰 ===
  const WaveData(
    wave: 21,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 12, delay: 0.5),
      EnemySpawn(enemyId: 'lethargy', count: 6, delay: 0.9),
      EnemySpawn(enemyId: 'trauma', count: 4, delay: 1.0),
      EnemySpawn(enemyId: 'burnout', count: 4, delay: 0.8),
    ],
    clearGold: 80,
    autoGold: 35,
  ),
  const WaveData(
    wave: 22,
    enemies: [
      EnemySpawn(enemyId: 'idle_thought', count: 15, delay: 0.5),
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.4),
      EnemySpawn(enemyId: 'burnout', count: 5, delay: 0.8),
    ],
    clearGold: 85,
    autoGold: 35,
  ),
  const WaveData(
    wave: 23,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 12, delay: 0.4),
      EnemySpawn(enemyId: 'lethargy', count: 8, delay: 0.8),
      EnemySpawn(enemyId: 'trauma', count: 5, delay: 1.0),
    ],
    clearGold: 85,
    autoGold: 40,
  ),
  const WaveData(
    wave: 24,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 15, delay: 0.4),
      EnemySpawn(enemyId: 'trauma', count: 6, delay: 0.9),
      EnemySpawn(enemyId: 'burnout', count: 6, delay: 0.7),
    ],
    clearGold: 90,
    autoGold: 40,
  ),
  const WaveData(
    wave: 25,
    enemies: [
      EnemySpawn(enemyId: 'lethargy', count: 8, delay: 0.8),
      EnemySpawn(enemyId: 'trauma', count: 6, delay: 0.8),
      EnemySpawn(enemyId: 'burnout', count: 6, delay: 0.7),
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.4),
    ],
    clearGold: 100,
    autoGold: 40,
  ),
  const WaveData(
    wave: 26,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 15, delay: 0.3),
      EnemySpawn(enemyId: 'lethargy', count: 8, delay: 0.7),
      EnemySpawn(enemyId: 'burnout', count: 8, delay: 0.6),
    ],
    clearGold: 100,
    autoGold: 40,
  ),
  const WaveData(
    wave: 27,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 15, delay: 0.3),
      EnemySpawn(enemyId: 'trauma', count: 8, delay: 0.7),
      EnemySpawn(enemyId: 'burnout', count: 8, delay: 0.6),
    ],
    clearGold: 110,
    autoGold: 45,
  ),
  const WaveData(
    wave: 28,
    enemies: [
      EnemySpawn(enemyId: 'lethargy', count: 10, delay: 0.6),
      EnemySpawn(enemyId: 'trauma', count: 8, delay: 0.7),
      EnemySpawn(enemyId: 'burnout', count: 8, delay: 0.5),
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.3),
    ],
    clearGold: 110,
    autoGold: 45,
  ),
  const WaveData(
    wave: 29,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 18, delay: 0.3),
      EnemySpawn(enemyId: 'lethargy', count: 10, delay: 0.5),
      EnemySpawn(enemyId: 'trauma', count: 8, delay: 0.6),
      EnemySpawn(enemyId: 'burnout', count: 10, delay: 0.5),
    ],
    clearGold: 120,
    autoGold: 50,
  ),

  // === Wave 30: 최종 보스(허무 x2) + 전 적 ===
  const WaveData(
    wave: 30,
    enemies: [
      EnemySpawn(enemyId: 'insomnia', count: 10, delay: 0.3),
      EnemySpawn(enemyId: 'lethargy', count: 6, delay: 0.6),
      EnemySpawn(enemyId: 'trauma', count: 5, delay: 0.7),
      EnemySpawn(enemyId: 'burnout', count: 6, delay: 0.5),
      EnemySpawn(enemyId: 'nihility', count: 2, delay: 3.0),
    ],
    clearGold: 200,
    autoGold: 50,
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
