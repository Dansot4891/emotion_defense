import '../../core/game_state.dart';
import '../../data/definitions/upgrade_defs.dart';
import '../components/character.dart';

/// 강화 시스템 — 캐릭터별 ATK/ASPD 골드 강화
class UpgradeSystem {
  final GameState gameState;

  UpgradeSystem({required this.gameState});

  /// ATK 강화 가능 여부
  bool canUpgradeAtk(CharacterComponent char) {
    if (char.atkUpgradeLevel >= maxUpgradeLevel) return false;
    return gameState.gold >= upgradeCosts[char.atkUpgradeLevel];
  }

  /// ASPD 강화 가능 여부
  bool canUpgradeAspd(CharacterComponent char) {
    if (char.aspdUpgradeLevel >= maxUpgradeLevel) return false;
    return gameState.gold >= upgradeCosts[char.aspdUpgradeLevel];
  }

  /// ATK 강화 비용
  int atkUpgradeCost(CharacterComponent char) {
    if (char.atkUpgradeLevel >= maxUpgradeLevel) return 0;
    return upgradeCosts[char.atkUpgradeLevel];
  }

  /// ASPD 강화 비용
  int aspdUpgradeCost(CharacterComponent char) {
    if (char.aspdUpgradeLevel >= maxUpgradeLevel) return 0;
    return upgradeCosts[char.aspdUpgradeLevel];
  }

  /// ATK 강화 실행
  bool upgradeAtk(CharacterComponent char) {
    if (!canUpgradeAtk(char)) return false;
    gameState.spendGold(upgradeCosts[char.atkUpgradeLevel]);
    char.atkUpgradeLevel++;
    return true;
  }

  /// ASPD 강화 실행
  bool upgradeAspd(CharacterComponent char) {
    if (!canUpgradeAspd(char)) return false;
    gameState.spendGold(upgradeCosts[char.aspdUpgradeLevel]);
    char.aspdUpgradeLevel++;
    return true;
  }
}
