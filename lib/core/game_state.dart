import 'package:flutter/foundation.dart';

import 'constants.dart';

/// 게임 진행 상태
enum GamePhase {
  preparing, // 웨이브 준비 (뽑기/배치 가능)
  waveActive, // 웨이브 진행 중
  gameOver, // 게임오버
  victory, // 승리 (모든 웨이브 클리어)
}

/// 게임 상태 관리 (ChangeNotifier로 UI 반응형 갱신)
class GameState extends ChangeNotifier {
  int _gold = GameConstants.startingGold;
  int _currentWave = 0; // 0 = 아직 시작 안 함, 1 = 첫 웨이브
  int _enemiesAlive = 0; // 맵에 살아있는 적 수
  GamePhase _phase = GamePhase.preparing;
  int _totalSpawned = 0; // 현재 웨이브에서 스폰된 적 수
  int _totalToSpawn = 0; // 현재 웨이브에서 스폰할 총 적 수

  // Getters
  int get gold => _gold;
  int get currentWave => _currentWave;
  int get enemiesAlive => _enemiesAlive;
  GamePhase get phase => _phase;
  int get totalSpawned => _totalSpawned;
  int get totalToSpawn => _totalToSpawn;

  /// 골드 추가
  void addGold(int amount) {
    _gold += amount;
    notifyListeners();
  }

  /// 골드 소비 (충분하면 true 반환)
  bool spendGold(int amount) {
    if (_gold >= amount) {
      _gold -= amount;
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
    if (_enemiesAlive >= GameConstants.maxAliveEnemies) {
      _phase = GamePhase.gameOver;
    }
    notifyListeners();
  }

  /// 적 처치됨
  void onEnemyKilled() {
    _enemiesAlive--;
    _checkWaveClear();
    notifyListeners();
  }

  /// 웨이브 클리어 판정
  void _checkWaveClear() {
    if (_phase != GamePhase.waveActive) return;
    if (_enemiesAlive <= 0 && _totalSpawned >= _totalToSpawn) {
      if (_currentWave >= GameConstants.totalWaves) {
        _phase = GamePhase.victory;
      } else {
        _phase = GamePhase.preparing;
      }
    }
  }

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
    notifyListeners();
  }
}
