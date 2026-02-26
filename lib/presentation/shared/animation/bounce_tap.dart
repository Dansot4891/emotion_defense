import 'package:emotion_defense/core/const/style/app_color.dart';
import 'package:flutter/material.dart';

/// 위젯 눌렀을 때 효과를 주기 위한 위젯
class BounceInteraction extends StatefulWidget {
  /// 인터렉션이 들어갈 위젯
  final Widget child;

  /// 버튼 모서리 round 값
  final double borderRadius;

  /// 버튼 눌렀을 때 효과가 들어갈 함수
  final VoidCallback? onTap;

  /// 배경색상
  final Color? backgroundColor;

  /// 버튼 눌렀을 때 효과가 들어갈 색상
  final Color? rippleColor;

  /// 버튼 모서리 모양
  final ShapeBorder? shape;

  /// 버튼 눌렀을 때 효과가 들어갈 크기
  final double scale;

  /// 버튼 눌렀을 때 효과가 들어갈 팩토리
  final InteractiveInkFeatureFactory? splashFactory;

  /// 버튼 눌렀을 때 효과가 들어갈 색상
  final Color disabledBackgroundColor;
  const BounceInteraction({
    super.key,
    required this.child,
    this.borderRadius = 10,
    this.onTap,
    this.backgroundColor,
    this.rippleColor,
    this.shape,
    this.scale = 0.985,
    this.splashFactory,
    this.disabledBackgroundColor = AppColor.disabled,
  });

  @override
  State<BounceInteraction> createState() => _BounceInteractionState();
}

class _BounceInteractionState extends State<BounceInteraction> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    /// 버튼의 함수가 null이라면
    /// 눌렀을 때 효과가 없도록 설정
    if (widget.onTap == null) {
      return Material(
        color: widget.backgroundColor ?? AppColor.white,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        shape: widget.shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor:
              widget.rippleColor ??
              AppColor.textDisabled.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          onTap: widget.onTap,
          child: widget.child,
        ),
      );
    }

    return Listener(
      /// 버튼 눌렀을 때
      onPointerDown: (event) {
        if (mounted) {
          setState(() {
            _isPressed = true;
          });
        }
      },

      /// 버튼 떼었을 때
      onPointerUp: (event) {
        if (mounted) {
          setState(() {
            _isPressed = false;
          });
        }
      },
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1.0,
        duration: const Duration(milliseconds: 50),
        child: Material(
          color: widget.backgroundColor ?? AppColor.white,
          borderRadius: _getBorderRadius(),
          shape: widget.shape,
          child: InkWell(
            splashFactory: widget.splashFactory,
            splashColor:
                widget.rippleColor ??
                AppColor.textDisabled.withValues(alpha: 0.2),
            customBorder: widget.shape,
            borderRadius: _getBorderRadius(),
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }

  /// shape 미 설정시, 버튼 모서리 라운드 계산
  BorderRadius? _getBorderRadius() {
    if (widget.shape == null) {
      return BorderRadius.circular(widget.borderRadius);
    }
    return null;
  }
}
