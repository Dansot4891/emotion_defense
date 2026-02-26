import 'package:emotion_defense/presentation/character_book/widgets/synergy/synergy_character_item.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';

/// 시너지 항목 데이터
class SynergyEntry {
  final String label;
  final String condition;
  final String effect;
  final Color color;
  final IconData icon;
  final List<String> characters;

  const SynergyEntry({
    required this.label,
    required this.condition,
    required this.effect,
    required this.color,
    required this.icon,
    required this.characters,
  });
}

/// 시너지 카드 — 하나의 시너지 조건+효과+해당 캐릭터 표시
class SynergyCard extends StatelessWidget {
  final SynergyEntry entry;

  const SynergyCard({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: entry.color.withValues(alpha: 0.3), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 아이콘
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: entry.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(entry.icon, color: entry.color, size: 22),
          ),
          const SizedBox(width: 12),
          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 라벨
                Text(
                  entry.condition,
                  style: AppTextStyle.hudLabel.copyWith(
                    fontSize: 13,
                    color: entry.color,
                  ),
                ),
                const SizedBox(height: 4),
                // 효과
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: entry.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    entry.effect,
                    style: TextStyle(
                      color: entry.color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // 해당 캐릭터 목록
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: entry.characters
                      .map(
                        (name) => SynergyCharacterItem(
                          name: name,
                          color: entry.color,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
