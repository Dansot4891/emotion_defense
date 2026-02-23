import '../../core/const/style/app_color.dart';
import '../../data/models/enemy_model.dart';

/// 잡념 - 기본 적 (Phase 1)
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

/// ID로 적 데이터 조회
EnemyData getEnemyData(String id) {
  switch (id) {
    case 'idle_thought':
      return idleThought;
    default:
      return idleThought;
  }
}
