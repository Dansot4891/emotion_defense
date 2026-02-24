import '../../core/game_state.dart';
import '../../data/definitions/character_defs.dart';
import '../../data/definitions/mission_defs.dart';
import '../../data/models/mission_model.dart';
import '../components/character.dart';

/// 미션 시스템 — 조건 체크, 진행률, 보상 적용
class MissionSystem {
  final GameState gameState;

  MissionSystem({required this.gameState});

  /// 모든 미션 조건 체크 — 새로 완료된 미션 ID 반환
  List<String> checkMissions(List<CharacterComponent> characters) {
    final newlyCompleted = <String>[];

    for (final mission in allMissions) {
      if (gameState.completedMissionIds.contains(mission.id)) continue;

      final progress = getMissionProgress(mission, characters);
      if (progress >= mission.targetValue) {
        gameState.completedMissionIds.add(mission.id);
        newlyCompleted.add(mission.id);
      }
    }

    return newlyCompleted;
  }

  /// 현재 진행률 반환
  int getMissionProgress(MissionData mission,
      [List<CharacterComponent>? characters]) {
    switch (mission.conditionType) {
      case MissionConditionType.killTotal:
        return gameState.totalEnemiesKilled;
      case MissionConditionType.reachWave:
        return gameState.currentWave;
      case MissionConditionType.earnGoldTotal:
        return gameState.totalGoldEarned;
      case MissionConditionType.haveAllCommon:
        if (characters == null) return 0;
        final placedIds =
            characters.map((c) => c.data.id).toSet();
        final commonIds = commonCharacters.map((c) => c.id).toSet();
        return commonIds.intersection(placedIds).length;
      case MissionConditionType.haveAllRare:
        if (characters == null) return 0;
        final placedRare = characters.map((c) => c.data.id).toSet();
        final rareIds = rareCharacters.map((c) => c.id).toSet();
        return rareIds.intersection(placedRare).length;
      case MissionConditionType.haveAllHero:
        if (characters == null) return 0;
        final placedHero = characters.map((c) => c.data.id).toSet();
        final heroIds = heroCharacters.map((c) => c.id).toSet();
        return heroIds.intersection(placedHero).length;
      case MissionConditionType.haveAllLegend:
        if (characters == null) return 0;
        final placedLegend = characters.map((c) => c.data.id).toSet();
        final legendIds = legendCharacters.map((c) => c.id).toSet();
        return legendIds.intersection(placedLegend).length;
      case MissionConditionType.killBoss:
        return gameState.bossKillCount;
      case MissionConditionType.combineCount:
        return gameState.totalCombineCount;
    }
  }

  /// 보상 수령 — 보상 적용 후 claimedMissionIds에 추가
  void claimReward(String missionId) {
    if (!gameState.completedMissionIds.contains(missionId)) return;
    if (gameState.claimedMissionIds.contains(missionId)) return;

    final mission = allMissions.firstWhere((m) => m.id == missionId);
    final reward = mission.reward;

    switch (reward.type) {
      case MissionRewardType.gold:
        gameState.addGold(reward.value.toInt());
        break;
      case MissionRewardType.permanentAtk:
        gameState.globalAtkBonus += reward.value;
        break;
      case MissionRewardType.permanentAspd:
        gameState.globalAspdBonus += reward.value;
        break;
      case MissionRewardType.enemyLimitBonus:
        gameState.maxAliveEnemiesBonus += reward.value.toInt();
        break;
      case MissionRewardType.gachaCostDiscount:
        gameState.gachaCostDiscount += reward.value.toInt();
        break;
    }

    gameState.claimedMissionIds.add(missionId);
    gameState.notify();
  }
}
