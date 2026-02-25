/// 적 이미지 에셋 경로
abstract class AppEnemyPath {
  static const _base = 'assets/images/enemies';

  /// 라운드별 일반 적
  static const String round10 = '$_base/enemy_round_10.png';
  static const String round20 = '$_base/enemy_round_20.png';
  static const String round30 = '$_base/enemy_round_30.png';

  /// 라운드별 보스
  static const String boss10 = '$_base/enemy_boss_10.png';
  static const String boss20 = '$_base/enemy_boss_20.png';
  static const String boss30 = '$_base/enemy_boss_30.png';

  /// 퀘스트 보스
  static const String questBoss = '$_base/enemy_quest_boss.png';

  /// 모든 적 이미지 경로 (프리로드용)
  static const List<String> allPaths = [
    round10, round20, round30,
    boss10, boss20, boss30,
    questBoss,
  ];

  /// 웨이브 + 보스 여부에 따른 이미지 경로 반환
  static String getImagePath({
    required int wave,
    required bool isBoss,
    bool isSummonedBoss = false,
  }) {
    // 퀘스트 소환 보스
    if (isSummonedBoss) return questBoss;

    // 보스
    if (isBoss) {
      if (wave <= 10) return boss10;
      if (wave <= 20) return boss20;
      return boss30;
    }

    // 일반 적
    if (wave <= 10) return round10;
    if (wave <= 20) return round20;
    return round30;
  }

  /// Flame 엔진용 경로 변환 (assets/images/ 접두사 제거)
  static String toFlamePath(String assetPath) =>
      assetPath.replaceFirst('assets/images/', '');
}
