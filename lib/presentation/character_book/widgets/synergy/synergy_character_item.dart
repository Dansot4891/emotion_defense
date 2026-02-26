import 'package:emotion_defense/core/const/style/app_text_style.dart';
import 'package:flutter/material.dart';

/// 캐릭터 이름 칩
class SynergyCharacterItem extends StatelessWidget {
  final String name;
  final Color color;

  const SynergyCharacterItem({
    required this.name,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: AppTextStyle.buttonMedium.copyWith(color: color),
      ),
    );
  }
}
