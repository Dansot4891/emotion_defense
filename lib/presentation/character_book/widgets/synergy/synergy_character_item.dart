import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/core/const/style/app_text_style.dart';
import 'package:emotion_defense/data/models/character_model.dart';
import 'package:flutter/material.dart';

/// 캐릭터 이름 칩
class SynergyCharacterItem extends StatelessWidget {
  final CharacterData character;
  final Color color;

  const SynergyCharacterItem({
    required this.character,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: character.grade.color, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        character.name.tr(),
        style: AppTextStyle.buttonMedium.copyWith(color: color),
      ),
    );
  }
}
