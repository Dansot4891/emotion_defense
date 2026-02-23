import 'dart:ui';

/// 앱 전체 색상 정의 — 모든 색상은 여기서만 관리
abstract class AppColor {
  // === 브랜드 / 배경 ===
  static const Color background = Color(0xFF0A0A23);
  static const Color surface = Color(0xFF0D1B2A);
  static const Color hudBackground = Color(0xDD1A1A2E);
  static const Color overlay = Color(0xEE1A1A2E);

  // === 액센트 ===
  static const Color primary = Color(0xFF3D5AFE);
  static const Color disabled = Color(0xFF424242);
  static const Color gold = Color(0xFFFFD700);

  // === 텍스트 ===
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color textMuted = Color(0xFF616161);
  static const Color textDisabled = Color(0xFF757575);

  // === 상태 ===
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color danger = Color(0xFFF44336);

  // === 타일 ===
  static const Color tilePath = Color(0xFF9E9E9E);
  static const Color tilePlacementEmpty = Color(0xFFA5D6A7);
  static const Color tilePlacementOccupied = Color(0xFF81C784);
  static const Color tileSpawn = Color(0xFF66BB6A);
  // tileEnd 제거 — 순환 루프이므로 종료 지점 없음
  static const Color tileBlocked = Color(0xFF616161);
  static const Color tileBorder = Color(0xFF424242);

  // === 캐릭터 (일반) ===
  static const Color charJoy = Color(0xFFFFD700);
  static const Color charSadness = Color(0xFF4169E1);
  static const Color charFear = Color(0xFF800080);
  static const Color charSurprise = Color(0xFFFF8C00);
  static const Color charLoneliness = Color(0xFF708090);
  static const Color charExcitement = Color(0xFFFF69B4);
  static const Color charBorder = Color(0xFFFFFFFF);

  // === 캐릭터 (레어) ===
  static const Color charAnger = Color(0xFFDC143C); // 빨강 (크림슨)
  static const Color charJealousy = Color(0xFF7CFC00); // 연두
  static const Color charAnxiety = Color(0xFF4B0082); // 짙은보라 (인디고)
  static const Color charNostalgia = Color(0xFF87CEEB); // 하늘
  static const Color charShame = Color(0xFF8B4513); // 갈색
  static const Color charGratitude = Color(0xFFFFB6C1); // 연분홍

  // === 캐릭터 (영웅) ===
  static const Color charMadness = Color(0xFFFF0040); // 짙은 빨강
  static const Color charResignation = Color(0xFF607D8B); // 청회색
  static const Color charHope = Color(0xFF00E676); // 밝은 초록
  static const Color charContempt = Color(0xFF6A0DAD); // 보라
  static const Color charSerenity = Color(0xFF00BCD4); // 시안
  static const Color charDread = Color(0xFF1A237E); // 짙은 남색

  // === 캐릭터 (전설) ===
  static const Color charPassion = Color(0xFFFF6D00); // 주황
  static const Color charVoid = Color(0xFF212121); // 짙은 검정
  static const Color charEnlightenment = Color(0xFFFFEB3B); // 노랑
  static const Color charLove = Color(0xFFE91E63); // 핑크

  // === 적 ===
  static const Color enemyIdleThought = Color(0xFF2F2F2F);
  static const Color enemyInsomnia = Color(0xFF1565C0); // 불면 (파랑)
  static const Color enemyLethargy = Color(0xFF5D4037); // 무기력 (갈색)
  static const Color enemyTrauma = Color(0xFF880E4F); // 트라우마 (자주)
  static const Color enemyBurnout = Color(0xFFE65100); // 번아웃 (주황)
  static const Color enemyNihility = Color(0xFF000000); // 허무 (검정)

  // === HP 바 ===
  static const Color hpBarBackground = Color(0xFF333333);
  static const Color hpHigh = Color(0xFF4CAF50);
  static const Color hpMid = Color(0xFFFF9800);
  static const Color hpLow = Color(0xFFF44336);

  // === 오버레이 / 테두리 ===
  static const Color borderGold = Color(0xFFFFD700);
  static const Color borderDanger = Color(0xFFF44336);
  static const Color rangeIndicator = Color(0x3300FF00);
}
