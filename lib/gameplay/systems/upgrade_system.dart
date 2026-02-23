import '../../core/game_state.dart';
import '../../data/definitions/upgrade_defs.dart';
import '../../data/models/character_model.dart';

/// 강화 시스템 — 등급별 ATK/ASPD 골드 강화
class UpgradeSystem {
  final GameState gameState;

  UpgradeSystem({required this.gameState});

  /// ATK 강화 가능 여부
  bool canUpgradeAtk(Grade grade) {
    final level = gameState.atkUpgradeLevels[grade]!;
    if (level >= maxUpgradeLevel) return false;
    return gameState.gold >= upgradeCosts[level];
  }

  /// ASPD 강화 가능 여부
  bool canUpgradeAspd(Grade grade) {
    final level = gameState.aspdUpgradeLevels[grade]!;
    if (level >= maxUpgradeLevel) return false;
    return gameState.gold >= upgradeCosts[level];
  }

  /// ATK 강화 비용
  int atkUpgradeCost(Grade grade) {
    final level = gameState.atkUpgradeLevels[grade]!;
    if (level >= maxUpgradeLevel) return 0;
    return upgradeCosts[level];
  }

  /// ASPD 강화 비용
  int aspdUpgradeCost(Grade grade) {
    final level = gameState.aspdUpgradeLevels[grade]!;
    if (level >= maxUpgradeLevel) return 0;
    return upgradeCosts[level];
  }

  /// ATK 강화 실행
  bool upgradeAtk(Grade grade) {
    if (!canUpgradeAtk(grade)) return false;
    final level = gameState.atkUpgradeLevels[grade]!;
    gameState.spendGold(upgradeCosts[level]);
    gameState.atkUpgradeLevels[grade] = level + 1;
    return true;
  }

  /// ASPD 강화 실행
  bool upgradeAspd(Grade grade) {
    if (!canUpgradeAspd(grade)) return false;
    final level = gameState.aspdUpgradeLevels[grade]!;
    gameState.spendGold(upgradeCosts[level]);
    gameState.aspdUpgradeLevels[grade] = level + 1;
    return true;
  }
}
