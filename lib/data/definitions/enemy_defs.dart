import '../../app/localization/locale_keys.dart';
import '../../core/const/style/app_color.dart';
import '../../data/definitions/boss_summon_defs.dart';
import '../../data/models/enemy_model.dart';

/// 잡념 - 기본 적
const EnemyData idleThought = EnemyData(
  id: 'idle_thought',
  name: LocaleKeys.enemyIdleThoughtName,
  hp: 50,
  def: 0,
  speed: 40.0,
  rewardGold: 5,
  color: AppColor.enemyIdleThought,
  description: LocaleKeys.enemyIdleThoughtDesc,
);

/// 불면 - 빠른 적
const EnemyData insomnia = EnemyData(
  id: 'insomnia',
  name: LocaleKeys.enemyInsomniaName,
  hp: 35,
  def: 0,
  speed: 70.0,
  rewardGold: 7,
  color: AppColor.enemyInsomnia,
  description: LocaleKeys.enemyInsomniaDesc,
);

/// 무기력 - 높은 HP
const EnemyData lethargy = EnemyData(
  id: 'lethargy',
  name: LocaleKeys.enemyLethargyName,
  hp: 120,
  def: 3,
  speed: 25.0,
  rewardGold: 10,
  color: AppColor.enemyLethargy,
  description: LocaleKeys.enemyLethargyDesc,
);

/// 트라우마 - 주변 적 HP 회복
const EnemyData trauma = EnemyData(
  id: 'trauma',
  name: LocaleKeys.enemyTraumaName,
  hp: 80,
  def: 2,
  speed: 35.0,
  rewardGold: 12,
  color: AppColor.enemyTrauma,
  description: LocaleKeys.enemyTraumaDesc,
  buffsNearby: true,
  nearbyBuffRange: 60.0,
  nearbyBuffValue: 5.0,
);

/// 번아웃 - 사망 시 분열
const EnemyData burnout = EnemyData(
  id: 'burnout',
  name: LocaleKeys.enemyBurnoutName,
  hp: 60,
  def: 1,
  speed: 45.0,
  rewardGold: 8,
  color: AppColor.enemyBurnout,
  description: LocaleKeys.enemyBurnoutDesc,
  splits: true,
  splitCount: 2,
  splitIntoId: 'burnout_split',
);

/// 번아웃 분열체
const EnemyData burnoutSplit = EnemyData(
  id: 'burnout_split',
  name: LocaleKeys.enemyBurnoutSplitName,
  hp: 25,
  def: 0,
  speed: 50.0,
  rewardGold: 3,
  color: AppColor.enemyBurnout,
  description: LocaleKeys.enemyBurnoutSplitDesc,
);

/// 허무 - 보스
const EnemyData nihility = EnemyData(
  id: 'nihility',
  name: LocaleKeys.enemyNihilityName,
  hp: 500,
  def: 5,
  speed: 20.0,
  rewardGold: 50,
  color: AppColor.enemyNihility,
  description: LocaleKeys.enemyNihilityDesc,
  isBoss: true,
);

/// ID로 적 데이터 조회
EnemyData getEnemyData(String id) {
  switch (id) {
    case 'idle_thought':
      return idleThought;
    case 'insomnia':
      return insomnia;
    case 'lethargy':
      return lethargy;
    case 'trauma':
      return trauma;
    case 'burnout':
      return burnout;
    case 'burnout_split':
      return burnoutSplit;
    case 'nihility':
      return nihility;
    case 'summoned_despair':
      return summonedDespair;
    default:
      return idleThought;
  }
}
