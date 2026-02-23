import 'dart:math';

import '../../data/models/reward_model.dart';

/// 보상 시스템 — 5웨이브마다 3개 중 1개 보상 선택
class RewardSystem {
  final Random _random = Random();

  /// 웨이브에 따른 보상 후보 풀 생성
  List<RewardOption> generateOptions(int wave) {
    final pool = <RewardOption>[];

    // 기본 보상 (모든 웨이브)
    pool.addAll([
      RewardOption(
        type: RewardType.bonusGold,
        name: '골드 보너스',
        description: '+${50 + wave * 10}G 즉시 획득',
        value: 50 + wave * 10,
      ),
      const RewardOption(
        type: RewardType.globalAtkBuff,
        name: '영구 공격력 UP',
        description: '전체 캐릭터 ATK +5%',
        value: 5,
      ),
      const RewardOption(
        type: RewardType.globalAspdBuff,
        name: '영구 공속 UP',
        description: '전체 캐릭터 ASPD +5%',
        value: 5,
      ),
      const RewardOption(
        type: RewardType.gachaCostDiscount,
        name: '뽑기 할인',
        description: '뽑기 비용 -5G',
        value: 5,
      ),
      const RewardOption(
        type: RewardType.enemyLimitIncrease,
        name: '적 한도 증가',
        description: '적 한도 +5',
        value: 5,
      ),
    ]);

    // 초반 (wave <= 10): 레어 캐릭터 추가
    if (wave <= 15) {
      pool.add(const RewardOption(
        type: RewardType.randomRare,
        name: '랜덤 레어',
        description: '레어 캐릭터 1체 즉시 획득',
        value: 1,
      ));
    }

    // 후반 (wave >= 15): 영웅 캐릭터 추가
    if (wave >= 15) {
      pool.add(const RewardOption(
        type: RewardType.randomHero,
        name: '랜덤 영웅',
        description: '영웅 캐릭터 1체 즉시 획득',
        value: 1,
      ));
    }

    // 셔플 후 3개 선택
    pool.shuffle(_random);
    return pool.take(3).toList();
  }
}
