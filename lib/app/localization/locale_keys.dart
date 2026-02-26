/// 로컬라이제이션 키 — JSON 경로와 1:1 매핑
abstract class LocaleKeys {
  // ── Common ──
  static const appName = 'common.appName';
  static const appSubtitle = 'common.appSubtitle';

  // ── Title Screen ──
  static const titleCharacterBook = 'title.characterBook';
  static const titleDifficulty = 'title.difficulty';
  static const titleStartGame = 'title.startGame';
  static const titleSubtitle = 'title.subtitle';

  // ── Game ──
  static const gamePause = 'game.pause';
  static const gameBgm = 'game.bgm';
  static const gameSfx = 'game.sfx';
  static const gameResume = 'game.resume';
  static const gameToTitle = 'game.toTitle';
  static const gameVictory = 'game.victory';
  static const gameGameOver = 'game.gameOver';
  static const gameWaveReached = 'game.waveReached';
  static const gameEnemiesKilled = 'game.enemiesKilled';
  static const gameGoldEarned = 'game.goldEarned';
  static const gameGoldSpent = 'game.goldSpent';
  static const gameGoldRemaining = 'game.goldRemaining';
  static const gameRestart = 'game.restart';
  static const gameSynergyCount = 'game.synergyCount';
  static const gameWaveClear = 'game.waveClear';
  static const gameSelectReward = 'game.selectReward';

  // ── Action Bar ──
  static const actionGacha = 'action.gacha';
  static const actionCombine = 'action.combine';
  static const actionUpgrade = 'action.upgrade';
  static const actionSelling = 'action.selling';
  static const actionSell = 'action.sell';
  static const actionQuest = 'action.quest';

  // ── Character Info ──
  static const characterInfoBaseAtk = 'characterInfo.baseAtk';
  static const characterInfoBaseAspd = 'characterInfo.baseAspd';
  static const characterInfoRangeTile = 'characterInfo.rangeTile';
  static const characterInfoPassive = 'characterInfo.passive';
  static const characterInfoActive = 'characterInfo.active';
  static const characterInfoNoSkill = 'characterInfo.noSkill';
  static const characterInfoReroll = 'characterInfo.reroll';

  // ── Combine Popup ──
  static const combineTitle = 'combine.title';
  static const combineAll = 'combine.all';
  static const combineButton = 'combine.button';

  // ── Upgrade Popup ──
  static const upgradeTitle = 'upgrade.title';
  static const upgradeAtk = 'upgrade.atk';
  static const upgradeAspd = 'upgrade.aspd';

  // ── Quest Popup ──
  static const questTitle = 'quest.title';
  static const questMission = 'quest.mission';
  static const questBossSummon = 'quest.bossSummon';
  static const questReward = 'quest.reward';
  static const questCompleted = 'quest.completed';
  static const questClaim = 'quest.claim';
  static const questSummon = 'quest.summon';
  static const questSummonCooldown = 'quest.summonCooldown';
  static const questSummonCount = 'quest.summonCount';
  static const questKillCount = 'quest.killCount';
  static const questCooldownInfo = 'quest.cooldownInfo';
  static const questBossHpInfo = 'quest.bossHpInfo';

  // ── Book (도감) ──
  static const bookTitle = 'book.title';
  static const bookCharacterTab = 'book.characterTab';
  static const bookSynergyTab = 'book.synergyTab';
  static const bookGradeTitle = 'book.gradeTitle';
  static const bookCharacterCount = 'book.characterCount';

  // ── Synergy ──
  static const synergyPolaritySynergy = 'synergy.polaritySynergy';
  static const synergyPolaritySynergyDesc = 'synergy.polaritySynergyDesc';
  static const synergyRoleSynergy = 'synergy.roleSynergy';
  static const synergyRoleSynergyDesc = 'synergy.roleSynergyDesc';
  static const synergyPositive3 = 'synergy.positive3';
  static const synergyPositive3Condition = 'synergy.positive3Condition';
  static const synergyPositive3Effect = 'synergy.positive3Effect';
  static const synergyPositive3EffectShort = 'synergy.positive3EffectShort';
  static const synergyPositive5 = 'synergy.positive5';
  static const synergyPositive5Condition = 'synergy.positive5Condition';
  static const synergyPositive5Effect = 'synergy.positive5Effect';
  static const synergyPositive5EffectShort = 'synergy.positive5EffectShort';
  static const synergyNegative3 = 'synergy.negative3';
  static const synergyNegative3Condition = 'synergy.negative3Condition';
  static const synergyNegative3Effect = 'synergy.negative3Effect';
  static const synergyNegative3EffectShort = 'synergy.negative3EffectShort';
  static const synergyNegative5 = 'synergy.negative5';
  static const synergyNegative5Condition = 'synergy.negative5Condition';
  static const synergyNegative5Effect = 'synergy.negative5Effect';
  static const synergyNegative5EffectShort = 'synergy.negative5EffectShort';
  static const synergyEmotionExplosion = 'synergy.emotionExplosion';
  static const synergyEmotionExplosionCondition = 'synergy.emotionExplosionCondition';
  static const synergyEmotionExplosionEffect = 'synergy.emotionExplosionEffect';
  static const synergyEmotionExplosionEffectShort = 'synergy.emotionExplosionEffectShort';
  static const synergyEmotionExplosionLabel = 'synergy.emotionExplosionLabel';
  static const synergyDealer3 = 'synergy.dealer3';
  static const synergyDealer3Condition = 'synergy.dealer3Condition';
  static const synergyDealer3Effect = 'synergy.dealer3Effect';
  static const synergyDealer3EffectShort = 'synergy.dealer3EffectShort';
  static const synergyStunner2 = 'synergy.stunner2';
  static const synergyStunner2Condition = 'synergy.stunner2Condition';
  static const synergyStunner2Effect = 'synergy.stunner2Effect';
  static const synergyStunner2EffectShort = 'synergy.stunner2EffectShort';
  static const synergyBuffer2 = 'synergy.buffer2';
  static const synergyBuffer2Condition = 'synergy.buffer2Condition';
  static const synergyBuffer2Effect = 'synergy.buffer2Effect';
  static const synergyBuffer2EffectShort = 'synergy.buffer2EffectShort';
  static const synergyDebuffer2 = 'synergy.debuffer2';
  static const synergyDebuffer2Condition = 'synergy.debuffer2Condition';
  static const synergyDebuffer2Effect = 'synergy.debuffer2Effect';
  static const synergyDebuffer2EffectShort = 'synergy.debuffer2EffectShort';

  // ── Grade ──
  static const gradeCommon = 'grade.common';
  static const gradeRare = 'grade.rare';
  static const gradeHero = 'grade.hero';
  static const gradeLegend = 'grade.legend';

  // ── Polarity ──
  static const polarityPositive = 'polarity.positive';
  static const polarityNegative = 'polarity.negative';
  static const polarityNeutral = 'polarity.neutral';

  // ── Role ──
  static const roleDealer = 'role.dealer';
  static const roleStunner = 'role.stunner';
  static const roleBuffer = 'role.buffer';
  static const roleDebuffer = 'role.debuffer';

  // ── Difficulty ──
  static const difficultyEasy = 'difficulty.easy';
  static const difficultyNormal = 'difficulty.normal';
  static const difficultyHard = 'difficulty.hard';
  static const difficultyHell = 'difficulty.hell';

  // ── Character (이름 + 설명 + 스킬) ──
  static const characterJoyName = 'character.joy.name';
  static const characterJoyDesc = 'character.joy.description';
  static const characterSadnessName = 'character.sadness.name';
  static const characterSadnessDesc = 'character.sadness.description';
  static const characterFearName = 'character.fear.name';
  static const characterFearDesc = 'character.fear.description';
  static const characterSurpriseName = 'character.surprise.name';
  static const characterSurpriseDesc = 'character.surprise.description';
  static const characterLonelinessName = 'character.loneliness.name';
  static const characterLonelinessDesc = 'character.loneliness.description';
  static const characterExcitementName = 'character.excitement.name';
  static const characterExcitementDesc = 'character.excitement.description';
  static const characterDisgustName = 'character.disgust.name';
  static const characterDisgustDesc = 'character.disgust.description';
  static const characterCuriosityName = 'character.curiosity.name';
  static const characterCuriosityDesc = 'character.curiosity.description';

  static const characterAngerName = 'character.anger.name';
  static const characterAngerDesc = 'character.anger.description';
  static const characterAngerActive1 = 'character.anger.active1';
  static const characterJealousyName = 'character.jealousy.name';
  static const characterJealousyDesc = 'character.jealousy.description';
  static const characterJealousyActive1 = 'character.jealousy.active1';
  static const characterAnxietyName = 'character.anxiety.name';
  static const characterAnxietyDesc = 'character.anxiety.description';
  static const characterAnxietyActive1 = 'character.anxiety.active1';
  static const characterNostalgiaName = 'character.nostalgia.name';
  static const characterNostalgiaDesc = 'character.nostalgia.description';
  static const characterNostalgiaPassive1 = 'character.nostalgia.passive1';
  static const characterShameName = 'character.shame.name';
  static const characterShameDesc = 'character.shame.description';
  static const characterShameActive1 = 'character.shame.active1';
  static const characterGratitudeName = 'character.gratitude.name';
  static const characterGratitudeDesc = 'character.gratitude.description';
  static const characterGratitudePassive1 = 'character.gratitude.passive1';
  static const characterRegretName = 'character.regret.name';
  static const characterRegretDesc = 'character.regret.description';
  static const characterRegretPassive1 = 'character.regret.passive1';
  static const characterWonderName = 'character.wonder.name';
  static const characterWonderDesc = 'character.wonder.description';
  static const characterWonderActive1 = 'character.wonder.active1';

  static const characterMadnessName = 'character.madness.name';
  static const characterMadnessDesc = 'character.madness.description';
  static const characterMadnessActive1 = 'character.madness.active1';
  static const characterMadnessActive2 = 'character.madness.active2';
  static const characterResignationName = 'character.resignation.name';
  static const characterResignationDesc = 'character.resignation.description';
  static const characterResignationActive1 = 'character.resignation.active1';
  static const characterResignationActive2 = 'character.resignation.active2';
  static const characterHopeName = 'character.hope.name';
  static const characterHopeDesc = 'character.hope.description';
  static const characterHopePassive1 = 'character.hope.passive1';
  static const characterHopePassive2 = 'character.hope.passive2';
  static const characterContemptName = 'character.contempt.name';
  static const characterContemptDesc = 'character.contempt.description';
  static const characterContemptActive1 = 'character.contempt.active1';
  static const characterContemptActive2 = 'character.contempt.active2';
  static const characterSerenityName = 'character.serenity.name';
  static const characterSerenityDesc = 'character.serenity.description';
  static const characterSerenityPassive1 = 'character.serenity.passive1';
  static const characterSerenityPassive2 = 'character.serenity.passive2';
  static const characterDreadName = 'character.dread.name';
  static const characterDreadDesc = 'character.dread.description';
  static const characterDreadPassive1 = 'character.dread.passive1';
  static const characterDreadActive1 = 'character.dread.active1';
  static const characterObsessionName = 'character.obsession.name';
  static const characterObsessionDesc = 'character.obsession.description';
  static const characterObsessionActive1 = 'character.obsession.active1';
  static const characterObsessionActive2 = 'character.obsession.active2';
  static const characterCourageName = 'character.courage.name';
  static const characterCourageDesc = 'character.courage.description';
  static const characterCourageActive1 = 'character.courage.active1';
  static const characterCouragePassive1 = 'character.courage.passive1';

  static const characterPassionName = 'character.passion.name';
  static const characterPassionDesc = 'character.passion.description';
  static const characterPassionActive1 = 'character.passion.active1';
  static const characterPassionActive2 = 'character.passion.active2';
  static const characterVoidCharName = 'character.voidChar.name';
  static const characterVoidCharDesc = 'character.voidChar.description';
  static const characterVoidCharPassive1 = 'character.voidChar.passive1';
  static const characterVoidCharActive1 = 'character.voidChar.active1';
  static const characterVoidCharActive2 = 'character.voidChar.active2';
  static const characterEnlightenmentName = 'character.enlightenment.name';
  static const characterEnlightenmentDesc = 'character.enlightenment.description';
  static const characterEnlightenmentPassive1 = 'character.enlightenment.passive1';
  static const characterEnlightenmentPassive2 = 'character.enlightenment.passive2';
  static const characterEnlightenmentActive1 = 'character.enlightenment.active1';
  static const characterLoveName = 'character.love.name';
  static const characterLoveDesc = 'character.love.description';
  static const characterLovePassive1 = 'character.love.passive1';
  static const characterLovePassive2 = 'character.love.passive2';
  static const characterLovePassive3 = 'character.love.passive3';
  static const characterVengeanceName = 'character.vengeance.name';
  static const characterVengeanceDesc = 'character.vengeance.description';
  static const characterVengeancePassive1 = 'character.vengeance.passive1';
  static const characterVengeanceActive1 = 'character.vengeance.active1';
  static const characterVengeanceActive2 = 'character.vengeance.active2';
  static const characterEcstasyName = 'character.ecstasy.name';
  static const characterEcstasyDesc = 'character.ecstasy.description';
  static const characterEcstasyPassive1 = 'character.ecstasy.passive1';
  static const characterEcstasyPassive2 = 'character.ecstasy.passive2';
  static const characterEcstasyActive1 = 'character.ecstasy.active1';

  // ── Enemy ──
  static const enemyIdleThoughtName = 'enemy.idleThought.name';
  static const enemyIdleThoughtDesc = 'enemy.idleThought.description';
  static const enemyInsomniaName = 'enemy.insomnia.name';
  static const enemyInsomniaDesc = 'enemy.insomnia.description';
  static const enemyLethargyName = 'enemy.lethargy.name';
  static const enemyLethargyDesc = 'enemy.lethargy.description';
  static const enemyTraumaName = 'enemy.trauma.name';
  static const enemyTraumaDesc = 'enemy.trauma.description';
  static const enemyBurnoutName = 'enemy.burnout.name';
  static const enemyBurnoutDesc = 'enemy.burnout.description';
  static const enemyBurnoutSplitName = 'enemy.burnoutSplit.name';
  static const enemyBurnoutSplitDesc = 'enemy.burnoutSplit.description';
  static const enemyNihilityName = 'enemy.nihility.name';
  static const enemyNihilityDesc = 'enemy.nihility.description';
  static const enemySummonedDespairName = 'enemy.summonedDespair.name';
  static const enemySummonedDespairDesc = 'enemy.summonedDespair.description';

  // ── Mission ──
  static const missionKill50Name = 'mission.kill50.name';
  static const missionKill50Desc = 'mission.kill50.description';
  static const missionKill50Reward = 'mission.kill50.reward';
  static const missionKill200Name = 'mission.kill200.name';
  static const missionKill200Desc = 'mission.kill200.description';
  static const missionKill200Reward = 'mission.kill200.reward';
  static const missionWave10Name = 'mission.wave10.name';
  static const missionWave10Desc = 'mission.wave10.description';
  static const missionWave10Reward = 'mission.wave10.reward';
  static const missionWave20Name = 'mission.wave20.name';
  static const missionWave20Desc = 'mission.wave20.description';
  static const missionWave20Reward = 'mission.wave20.reward';
  static const missionGold500Name = 'mission.gold500.name';
  static const missionGold500Desc = 'mission.gold500.description';
  static const missionGold500Reward = 'mission.gold500.reward';
  static const missionCollectAllCommonName = 'mission.collectAllCommon.name';
  static const missionCollectAllCommonDesc = 'mission.collectAllCommon.description';
  static const missionCollectAllCommonReward = 'mission.collectAllCommon.reward';
  static const missionCollectAllRareName = 'mission.collectAllRare.name';
  static const missionCollectAllRareDesc = 'mission.collectAllRare.description';
  static const missionCollectAllRareReward = 'mission.collectAllRare.reward';
  static const missionCollectAllHeroName = 'mission.collectAllHero.name';
  static const missionCollectAllHeroDesc = 'mission.collectAllHero.description';
  static const missionCollectAllHeroReward = 'mission.collectAllHero.reward';
  static const missionCollectAllLegendName = 'mission.collectAllLegend.name';
  static const missionCollectAllLegendDesc = 'mission.collectAllLegend.description';
  static const missionCollectAllLegendReward = 'mission.collectAllLegend.reward';
  static const missionKillBoss1Name = 'mission.killBoss1.name';
  static const missionKillBoss1Desc = 'mission.killBoss1.description';
  static const missionKillBoss1Reward = 'mission.killBoss1.reward';
  static const missionCombine5Name = 'mission.combine5.name';
  static const missionCombine5Desc = 'mission.combine5.description';
  static const missionCombine5Reward = 'mission.combine5.reward';

  // ── Reward ──
  static const rewardBonusGoldName = 'reward.bonusGold.name';
  static const rewardBonusGoldDesc = 'reward.bonusGold.description';
  static const rewardGlobalAtkBuffName = 'reward.globalAtkBuff.name';
  static const rewardGlobalAtkBuffDesc = 'reward.globalAtkBuff.description';
  static const rewardGlobalAspdBuffName = 'reward.globalAspdBuff.name';
  static const rewardGlobalAspdBuffDesc = 'reward.globalAspdBuff.description';
  static const rewardGachaCostDiscountName = 'reward.gachaCostDiscount.name';
  static const rewardGachaCostDiscountDesc = 'reward.gachaCostDiscount.description';
  static const rewardEnemyLimitIncreaseName = 'reward.enemyLimitIncrease.name';
  static const rewardEnemyLimitIncreaseDesc = 'reward.enemyLimitIncrease.description';
  static const rewardRandomRareName = 'reward.randomRare.name';
  static const rewardRandomRareDesc = 'reward.randomRare.description';
  static const rewardRandomHeroName = 'reward.randomHero.name';
  static const rewardRandomHeroDesc = 'reward.randomHero.description';
}
