import '../../app/localization/locale_keys.dart';
import '../../core/const/style/app_color.dart';
import '../models/enemy_model.dart';

/// 소환 보스 — 절망
const EnemyData summonedDespair = EnemyData(
  id: 'summoned_despair',
  name: LocaleKeys.enemySummonedDespairName,
  hp: 400,
  def: 3,
  speed: 25.0,
  rewardGold: 80,
  color: AppColor.enemySummonedBoss,
  description: LocaleKeys.enemySummonedDespairDesc,
  isBoss: true,
  isSummonedBoss: true,
);

/// HP 스케일링 (소환 횟수 기반)
double bossSummonHpScale(int count) => 1.0 + (count - 1) * 0.3;

/// 보상 골드 (소환 횟수 기반) — 비용 없으므로 보상 낮게
int bossSummonRewardGold(int count) => 30 + (count - 1) * 10;

/// 소환 쿨타임 (웨이브 단위)
const int bossSummonCooldownWaves = 5;
