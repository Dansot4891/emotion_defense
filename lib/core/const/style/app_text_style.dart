import 'package:flutter/material.dart';

import 'app_color.dart';

/// 앱 전체 텍스트 스타일 정의 — 모든 텍스트 스타일은 여기서만 관리
abstract class AppTextStyle {
  // === 타이틀 ===
  static const TextStyle title = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 40,
    fontWeight: FontWeight.bold,
    letterSpacing: 4,
  );

  static const TextStyle subtitle = TextStyle(
    color: AppColor.textSecondary,
    fontSize: 16,
    letterSpacing: 2,
  );

  // === HUD ===
  static const TextStyle hudLabel = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  // === 버튼 ===
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonSmall = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 9,
    fontWeight: FontWeight.bold,
  );

  static TextStyle buttonSmallDisabled = buttonSmall.copyWith(
    color: AppColor.textDisabled,
  );

  // === 게임 내 ===
  static const TextStyle tileMarker = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle charLabel = TextStyle(
    color: AppColor.textPrimary,
    fontSize: 10,
    fontWeight: FontWeight.bold,
  );

  // === 게임오버 ===
  static const TextStyle gameOverTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle gameOverSubtitle = TextStyle(
    color: AppColor.textSecondary,
    fontSize: 16,
  );

  // === 기타 ===
  static const TextStyle caption = TextStyle(
    color: AppColor.textMuted,
    fontSize: 12,
  );
}
