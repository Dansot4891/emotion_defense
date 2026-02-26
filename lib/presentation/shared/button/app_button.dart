import 'package:emotion_defense/core/const/style/app_color.dart';
import 'package:emotion_defense/core/const/style/app_text_style.dart';
import 'package:emotion_defense/presentation/shared/animation/bounce_tap.dart';
import 'package:flutter/material.dart';

/// 기본으로 사용되는 좌우 넓은 앱 버튼
class AppButton extends StatelessWidget {
  /// --- text style ---
  final Color? textColor;
  // --- --- --- --- ---
  final String text;
  final Color? bgColor;
  final Border? border;
  final VoidCallback? onTap;
  final double borderRadius;
  final double verticalPadding;
  final double horizontalPadding;
  final bool isExpanded;
  final Widget? widget;
  final TextStyle? textStyle;
  final bool enabled;

  final Color? rippleColor;

  const AppButton({
    required this.text,

    /// --- text style ---
    this.textColor,

    /// --- --- --- --- ---
    this.bgColor,
    this.border,
    this.borderRadius = 12,
    this.verticalPadding = 16,
    this.horizontalPadding = 0,
    this.isExpanded = false,
    required this.onTap,
    this.widget,
    this.textStyle,
    this.enabled = true,
    this.rippleColor,
    super.key,
  });

  factory AppButton.basePrimary({
    required String text,
    VoidCallback? onTap,
    Color textColor = AppColor.white,
    Color bgColor = AppColor.primary,
    Border? border,
    double borderRadius = 12,
    double verticalPadding = 16,
    double horizontalPadding = 0,
    bool isExpanded = false,
    Widget? widget,
    bool enabled = true,
  }) {
    return AppButton(
      text: text,
      onTap: enabled ? onTap : null,
      textColor: textColor,
      bgColor: bgColor,
      border: border,
      borderRadius: borderRadius,
      verticalPadding: verticalPadding,
      horizontalPadding: horizontalPadding,
      isExpanded: isExpanded,
      widget: widget,
      enabled: enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    /// 1. expanded 일 때
    if (isExpanded) {
      return Expanded(
        child: BounceInteraction(
          rippleColor: rippleColor,
          onTap: onTap,
          backgroundColor: onTap == null
              ? AppColor.disabled
              : bgColor ?? AppColor.white,
          borderRadius: borderRadius,
          child: appButton(),
        ),
      );
    }

    /// 2. expanded 아닐 때
    return BounceInteraction(
      onTap: onTap,
      rippleColor: rippleColor,
      backgroundColor: onTap == null
          ? AppColor.disabled
          : bgColor ?? AppColor.white,
      borderRadius: borderRadius,
      child: appButton(),
    );
  }

  /// 버튼 빌드
  Widget appButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child:
          widget ??
          Center(
            child: Text(
              text,
              style:
                  textStyle ??
                  AppTextStyle.buttonSmall.copyWith(
                    color: onTap == null ? AppColor.textDisabled : textColor,
                  ),
            ),
          ),
    );
  }
}
