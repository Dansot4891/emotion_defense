import 'package:flutter/foundation.dart';

import '../app/localization/locale_keys.dart';
import '../data/models/character_model.dart';
import 'constants.dart';

/// 난이도
enum Difficulty {
  easy(label: LocaleKeys.difficultyEasy, hpMult: 0.7, defMult: 0.7, speedMult: 0.85),
  normal(label: LocaleKeys.difficultyNormal, hpMult: 1.0, defMult: 1.0, speedMult: 1.0),
  hard(label: LocaleKeys.difficultyHard, hpMult: 1.4, defMult: 1.3, speedMult: 1.15),
  hell(label: LocaleKeys.difficultyHell, hpMult: 2.0, defMult: 1.6, speedMult: 1.3);

  final String label;
  final double hpMult; // 적 HP 배율
  final double defMult; // 적 DEF 배율
  final double speedMult; // 적 이동속도 배율

  const Difficulty({
    required this.label,
    required this.hpMult,
    required this.defMult,
    required this.speedMult,
  });
}

/// 게임 진행 상태
enum GamePhase {
  preparing, // 웨이브 준비 (뽑기/배치 가능)
  waveActive, // 웨이브 진행 중
  gameOver, // 게임오버
  victory, // 승리 (모든 웨이브 클리어)
}

/// 게임 상태 관리 (ChangeNotifier로 UI 반응형 갱신)
class GameState extends ChangeNotifier {
  Difficulty difficulty = Difficulty.normal;

  int _gold = GameConstants.startingGold;
  int _currentWave = 0; // 0 = 아직 시작 안 함, 1 = 첫 웨이브
  int _enemiesAlive = 0; // 맵에 살아있는 적 수
  GamePhase _phase = GamePhase.preparing;
  int _totalSpawned = 0; // 현재 웨이브에서 스폰된 적 수
  int _totalToSpawn = 0; // 현재 웨이브에서 스폰할 총 적 수

  // 등급별 강화 레벨
  final Map<Grade, int> atkUpgradeLevels = {
    for (final g in Grade.values) g: 0,
  };
  final Map<Grade, int> aspdUpgradeLevels = {
    for (final g in Grade.values) g: 0,
  };

  // 보상 누적 보너스
  double globalAtkBonus = 0;
  double globalAspdBonus = 0;
  int maxAliveEnemiesBonus = 0;
  int gachaCostDiscount = 0;

  // 통계 (게임오버/승리 화면용)
  int totalEnemiesKilled = 0;
  int totalGoldEarned = 0;
  int totalGoldSpent = 0;

  // 퀘스트 시스템
  final Set<String> completedMissionIds = {}; // 조건 달성된 미션
  final Set<String> claimedMissionIds = {}; // 보상 수령 완료 미션
  int bossSummonCount = 0; // 보스 소환 횟수
  int bossKillCount = 0; // 소환 보스 처치 횟수
  int lastBossSummonWave = 0; // 마지막 소환 시 웨이브
  int totalCombineCount = 0; // 조합 횟수

  // Getters
  int get gold => _gold;
  int get currentWave => _currentWave;
  int get enemiesAlive => _enemiesAlive;
  GamePhase get phase => _phase;
  int get totalSpawned => _totalSpawned;
  int get totalToSpawn => _totalToSpawn;

  /// 실효 적 한도
  int get effectiveMaxAliveEnemies =>
      GameConstants.maxAliveEnemies + maxAliveEnemiesBonus;

  /// 실효 뽑기 비용
  int get effectiveGachaCost =>
      (GameConstants.gachaCost - gachaCostDiscount).clamp(5, 999);

  /// 골드 추가
  void addGold(int amount) {
    _gold += amount;
    totalGoldEarned += amount;
    notifyListeners();
  }

  /// 골드 소비 (충분하면 true 반환)
  bool spendGold(int amount) {
    if (_gold >= amount) {
      _gold -= amount;
      totalGoldSpent += amount;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// 웨이브 시작
  void startWave(int waveNumber, int totalEnemies) {
    _currentWave = waveNumber;
    _phase = GamePhase.waveActive;
    _totalSpawned = 0;
    _totalToSpawn = totalEnemies;
    notifyListeners();
  }

  /// 적 스폰됨 — 살아있는 적이 한도 초과 시 게임오버
  void onEnemySpawned() {
    _enemiesAlive++;
    _totalSpawned++;
    if (_enemiesAlive >= effectiveMaxAliveEnemies) {
      _phase = GamePhase.gameOver;
    }
    _checkWaveClear();
    notifyListeners();
  }

  /// 적 처치됨
  void onEnemyKilled() {
    _enemiesAlive--;
    totalEnemiesKilled++;
    _checkWaveClear();
    notifyListeners();
  }

  /// 웨이브 클리어 판정
  /// - 일반 웨이브: 스폰 완료 시 바로 다음 웨이브 준비 (남은 적은 누적)
  /// - 최종 웨이브: 적 전멸 시 승리
  void _checkWaveClear() {
    if (_phase != GamePhase.waveActive) return;
    if (_totalSpawned >= _totalToSpawn) {
      if (_currentWave >= GameConstants.totalWaves) {
        // 최종 웨이브는 적 전멸 필요
        if (_enemiesAlive <= 0) {
          _phase = GamePhase.victory;
        }
      } else {
        _phase = GamePhase.preparing;
      }
    }
  }

  /// 소환 보스 스폰 — _enemiesAlive만 증가 (웨이브 카운트 건드리지 않음)
  void onSummonedBossSpawned() {
    _enemiesAlive++;
    if (_enemiesAlive >= effectiveMaxAliveEnemies) {
      _phase = GamePhase.gameOver;
    }
    notifyListeners();
  }

  /// 소환 보스 처치
  void onSummonedBossKilled() {
    bossKillCount++;
    notifyListeners();
  }

  /// 완료됐지만 미수령 미션 존재 여부
  bool get hasPendingMissionReward =>
      completedMissionIds.any((id) => !claimedMissionIds.contains(id));

  /// UI 갱신 트리거 (외부에서 호출 가능)
  void notify() {
    notifyListeners();
  }

  /// 게임 리셋
  void reset() {
    _gold = GameConstants.startingGold;
    _currentWave = 0;
    _enemiesAlive = 0;
    _phase = GamePhase.preparing;
    _totalSpawned = 0;
    _totalToSpawn = 0;
    for (final g in Grade.values) {
      atkUpgradeLevels[g] = 0;
      aspdUpgradeLevels[g] = 0;
    }
    globalAtkBonus = 0;
    globalAspdBonus = 0;
    maxAliveEnemiesBonus = 0;
    gachaCostDiscount = 0;
    totalEnemiesKilled = 0;
    totalGoldEarned = 0;
    totalGoldSpent = 0;
    completedMissionIds.clear();
    claimedMissionIds.clear();
    bossSummonCount = 0;
    bossKillCount = 0;
    lastBossSummonWave = 0;
    totalCombineCount = 0;
    notifyListeners();
  }
}
