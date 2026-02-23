/// 게임 상수 정의
class GameConstants {
  GameConstants._();

  // 격자 맵
  static const int gridColumns = 6;
  static const int gridRows = 10;

  // 경제
  static const int startingGold = 100;
  static const int gachaCost = 30;

  // 게임오버
  static const int maxLeakedEnemies = 20;

  // 웨이브
  static const int totalWaves = 30;
  static const int waveStartBonusGold = 10;

  // 전투
  static const double projectileSpeed = 300.0; // 픽셀/초

  // 판매 환급률
  static const double sellRefundRate = 0.5;

  // UI 영역 높이 (비율)
  static const double hudHeight = 48.0;
  static const double actionBarHeight = 64.0;
}
