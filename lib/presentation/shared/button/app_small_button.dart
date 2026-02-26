import 'package:emotion_defense/core/const/style/app_color.dart';
import 'package:emotion_defense/core/const/style/app_text_style.dart';
import 'package:emotion_defense/presentation/shared/animation/bounce_tap.dart';
import 'package:flutter/material.dart';

// 앱에서 사용되는 작은 버튼
class AppSmallButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double verticalPadding;
  final double horizontalPadding;
  final TextStyle? textStyle;
  final double borderRadius;
  final Color? rippleColor;
  final bool isBorder;
  final double? height;
  final double? minWidth;
  final Alignment? alignment;
  final Widget? widget;

  const AppSmallButton({
    super.key,
    this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.verticalPadding = 9,
    this.horizontalPadding = 10,
    this.borderRadius = 8,
    this.textStyle,
    this.rippleColor,
    this.isBorder = true,
    this.height,
    this.minWidth,
    this.alignment,
    this.widget,
  });

  static const Color _defaultBackgroundColor = AppColor.surface;
  static const Color _defaultTextColor = AppColor.textPrimary;
  static const Color _defaultBorderColor = AppColor.primary;

  @override
  Widget build(BuildContext context) {
    return BounceInteraction(
      onTap: onTap,
      backgroundColor: backgroundColor ?? _defaultBackgroundColor,
      borderRadius: borderRadius,
      rippleColor: rippleColor,
      child: Container(
        height: height,
        constraints: BoxConstraints(minWidth: minWidth ?? 0),
        alignment: alignment,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          border: isBorder
              ? Border.all(color: borderColor ?? _defaultBorderColor)
              : null,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child:
            widget ??
            Text(
              text,
              style:
                  textStyle ??
                  AppTextStyle.buttonSmall.copyWith(
                    color: textColor ?? _defaultTextColor,
                  ),
            ),
      ),
    );
  }
}
