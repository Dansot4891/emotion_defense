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
  static const Color tileEnd = Color(0xFFEF5350);
  static const Color tileBlocked = Color(0xFF616161);
  static const Color tileBorder = Color(0xFF424242);

  // === 캐릭터 ===
  static const Color charJoy = Color(0xFFFFD700);
  static const Color charSadness = Color(0xFF4169E1);
  static const Color charFear = Color(0xFF800080);
  static const Color charSurprise = Color(0xFFFF8C00);
  static const Color charLoneliness = Color(0xFF708090);
  static const Color charExcitement = Color(0xFFFF69B4);
  static const Color charBorder = Color(0xFFFFFFFF);

  // === 적 ===
  static const Color enemyIdleThought = Color(0xFF2F2F2F);

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
