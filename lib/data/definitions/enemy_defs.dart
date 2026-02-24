import '../../core/const/style/app_color.dart';
import '../../data/definitions/boss_summon_defs.dart';
import '../../data/models/enemy_model.dart';

/// 잡념 - 기본 적
const EnemyData idleThought = EnemyData(
  id: 'idle_thought',
  name: '잡념',
  hp: 50,
  def: 0,
  speed: 40.0,
  rewardGold: 5,
  color: AppColor.enemyIdleThought,
  description: '기본적인 잡념, 느리고 약함',
);

/// 불면 - 빠른 적
const EnemyData insomnia = EnemyData(
  id: 'insomnia',
  name: '불면',
  hp: 35,
  def: 0,
  speed: 70.0,
  rewardGold: 7,
  color: AppColor.enemyInsomnia,
  description: '빠르게 이동하는 불면',
);

/// 무기력 - 높은 HP
const EnemyData lethargy = EnemyData(
  id: 'lethargy',
  name: '무기력',
  hp: 120,
  def: 3,
  speed: 25.0,
  rewardGold: 10,
  color: AppColor.enemyLethargy,
  description: '느리지만 HP가 높은 무기력',
);

/// 트라우마 - 주변 적 HP 회복
const EnemyData trauma = EnemyData(
  id: 'trauma',
  name: '트라우마',
  hp: 80,
  def: 2,
  speed: 35.0,
  rewardGold: 12,
  color: AppColor.enemyTrauma,
  description: '주변 적의 HP를 회복시키는 트라우마',
  buffsNearby: true,
  nearbyBuffRange: 60.0,
  nearbyBuffValue: 5.0,
);

/// 번아웃 - 사망 시 분열
const EnemyData burnout = EnemyData(
  id: 'burnout',
  name: '번아웃',
  hp: 60,
  def: 1,
  speed: 45.0,
  rewardGold: 8,
  color: AppColor.enemyBurnout,
  description: '죽으면 2마리로 분열하는 번아웃',
  splits: true,
  splitCount: 2,
  splitIntoId: 'burnout_split',
);

/// 번아웃 분열체
const EnemyData burnoutSplit = EnemyData(
  id: 'burnout_split',
  name: '잔열',
  hp: 25,
  def: 0,
  speed: 50.0,
  rewardGold: 3,
  color: AppColor.enemyBurnout,
  description: '번아웃의 분열체',
);

/// 허무 - 보스
const EnemyData nihility = EnemyData(
  id: 'nihility',
  name: '허무',
  hp: 500,
  def: 5,
  speed: 20.0,
  rewardGold: 50,
  color: AppColor.enemyNihility,
  description: '거대한 보스 - 허무',
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
