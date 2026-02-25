import 'package:emotion_defense/core/const/style/app_color.dart';
import 'package:emotion_defense/core/game_state.dart';
import 'package:flutter/material.dart';

class TitleDifficultItem extends StatelessWidget {
  final Difficulty difficulty;
  final VoidCallback onTap;
  final bool selected;
  const TitleDifficultItem({
    super.key,
    required this.difficulty,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? _difficultyColor(difficulty).withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected
                  ? _difficultyColor(difficulty)
                  : AppColor.textMuted,
              width: selected ? 2 : 1,
            ),
          ),
          child: Text(
            difficulty.label,
            style: TextStyle(
              color: selected
                  ? _difficultyColor(difficulty)
                  : AppColor.textSecondary,
              fontSize: 14,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  /// 난이도 색상
  Color _difficultyColor(Difficulty d) {
    switch (d) {
      case Difficulty.easy:
        return AppColor.success;
      case Difficulty.normal:
        return AppColor.primary;
      case Difficulty.hard:
        return AppColor.warning;
      case Difficulty.hell:
        return AppColor.danger;
    }
  }
}
