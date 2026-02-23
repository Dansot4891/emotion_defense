/// 웨이브 내 적 스폰 정보
class EnemySpawn {
  final String enemyId;
  final int count;
  final double delay; // 스폰 간격 (초)

  const EnemySpawn({
    required this.enemyId,
    required this.count,
    required this.delay,
  });
}

/// 웨이브 데이터 정의
class WaveData {
  final int wave;
  final List<EnemySpawn> enemies;
  final int clearGold; // 웨이브 클리어 보너스
  final int autoGold; // 웨이브 시작 시 자동 지급

  const WaveData({
    required this.wave,
    required this.enemies,
    required this.clearGold,
    required this.autoGold,
  });
}
