import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

import '../../app/localization/locale_keys.dart';
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
        name: LocaleKeys.rewardBonusGoldName.tr(),
        description: LocaleKeys.rewardBonusGoldDesc.tr(namedArgs: {'value': '${50 + wave * 10}'}),
        value: 50 + wave * 10,
      ),
      RewardOption(
        type: RewardType.globalAtkBuff,
        name: LocaleKeys.rewardGlobalAtkBuffName.tr(),
        description: LocaleKeys.rewardGlobalAtkBuffDesc.tr(),
        value: 5,
      ),
      RewardOption(
        type: RewardType.globalAspdBuff,
        name: LocaleKeys.rewardGlobalAspdBuffName.tr(),
        description: LocaleKeys.rewardGlobalAspdBuffDesc.tr(),
        value: 5,
      ),
      RewardOption(
        type: RewardType.gachaCostDiscount,
        name: LocaleKeys.rewardGachaCostDiscountName.tr(),
        description: LocaleKeys.rewardGachaCostDiscountDesc.tr(),
        value: 5,
      ),
      RewardOption(
        type: RewardType.enemyLimitIncrease,
        name: LocaleKeys.rewardEnemyLimitIncreaseName.tr(),
        description: LocaleKeys.rewardEnemyLimitIncreaseDesc.tr(),
        value: 5,
      ),
    ]);

    // 초반 (wave <= 10): 레어 캐릭터 추가
    if (wave <= 15) {
      pool.add(RewardOption(
        type: RewardType.randomRare,
        name: LocaleKeys.rewardRandomRareName.tr(),
        description: LocaleKeys.rewardRandomRareDesc.tr(),
        value: 1,
      ));
    }

    // 후반 (wave >= 15): 영웅 캐릭터 추가
    if (wave >= 15) {
      pool.add(RewardOption(
        type: RewardType.randomHero,
        name: LocaleKeys.rewardRandomHeroName.tr(),
        description: LocaleKeys.rewardRandomHeroDesc.tr(),
        value: 1,
      ));
    }

    // 셔플 후 3개 선택
    pool.shuffle(_random);
    return pool.take(3).toList();
  }
}
