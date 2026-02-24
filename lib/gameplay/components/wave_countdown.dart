import 'dart:ui';

import 'package:flame/components.dart';

/// 웨이브 시작 전 스폰 지점에 3, 2, 1 카운트다운 표시
class WaveCountdownComponent extends PositionComponent {
  final double tileSize;

  int _displayNumber = 3;
  int get displayNumber => _displayNumber;

  WaveCountdownComponent({
    required Vector2 spawnCenter,
    required this.tileSize,
  }) : super(
          position: spawnCenter,
          anchor: Anchor.center,
        );

  /// 남은 시간(초)에 따라 표시 숫자 업데이트
  void updateFromDelay(double delay) {
    if (delay > 2.0) {
      _displayNumber = 3;
    } else if (delay > 1.0) {
      _displayNumber = 2;
    } else {
      _displayNumber = 1;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final fontSize = tileSize * 0.8;

    // 반투명 원형 배경
    final bgPaint = Paint()
      ..color = const Color(0xCC000000)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, tileSize * 0.45, bgPaint);

    // 숫자 텍스트
    final paragraphBuilder = ParagraphBuilder(ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: fontSize,
    ))
      ..pushStyle(TextStyle(
        color: const Color(0xFFFFFFFF),
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ))
      ..addText('$_displayNumber');

    final paragraph = paragraphBuilder.build()
      ..layout(const ParagraphConstraints(width: 200));

    canvas.drawParagraph(
      paragraph,
      Offset(-100, -fontSize * 0.55),
    );
  }
}
