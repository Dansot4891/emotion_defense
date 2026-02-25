import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/const/style/app_text_style.dart';
import '../../../core/emotion_defense_game.dart';
import '../../../data/definitions/character_defs.dart';
import '../../../data/definitions/recipe_defs.dart';
import '../../../data/models/character_model.dart';
import '../../../data/models/recipe_model.dart';

/// 등급별 통일 색상
Color _gradeColor(Grade? grade) {
  switch (grade) {
    case Grade.common:
      return AppColor.gradeCommon;
    case Grade.rare:
      return AppColor.gradeRare;
    case Grade.hero:
      return AppColor.gradeHero;
    case Grade.legend:
      return AppColor.gradeLegend;
    case null:
      return AppColor.textPrimary;
  }
}

/// 조합표 팝업 오버레이 — 등급 필터 + 레시피 목록 + 조합 실행
class CombinePopup extends StatefulWidget {
  final EmotionDefenseGame game;

  const CombinePopup({super.key, required this.game});

  @override
  State<CombinePopup> createState() => _CombinePopupState();
}

class _CombinePopupState extends State<CombinePopup> {
  Grade? _selectedGrade; // null = 전체

  List<RecipeData> get _filteredRecipes {
    if (_selectedGrade == null) return allRecipes;
    return allRecipes.where((r) {
      final result = allCharacters[r.resultId];
      return result?.grade == _selectedGrade;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.overlay,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColor.primary, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('조합표', style: AppTextStyle.hudLabel),
                GestureDetector(
                  onTap: () => widget.game.toggleCombinePopup(),
                  child: const Icon(
                    Icons.close,
                    color: AppColor.textSecondary,
                    size: 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 등급 필터 탭
            Row(
              children: [
                _FilterTab(
                  label: '전체',
                  selected: _selectedGrade == null,
                  color: AppColor.textPrimary,
                  onTap: () => setState(() => _selectedGrade = null),
                ),
                _FilterTab(
                  label: '레어',
                  selected: _selectedGrade == Grade.rare,
                  color: AppColor.gradeRare,
                  onTap: () => setState(() => _selectedGrade = Grade.rare),
                ),
                _FilterTab(
                  label: '영웅',
                  selected: _selectedGrade == Grade.hero,
                  color: AppColor.gradeHero,
                  onTap: () => setState(() => _selectedGrade = Grade.hero),
                ),
                _FilterTab(
                  label: '전설',
                  selected: _selectedGrade == Grade.legend,
                  color: AppColor.gradeLegend,
                  onTap: () => setState(() => _selectedGrade = Grade.legend),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 레시피 목록
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _filteredRecipes.length,
                separatorBuilder: (_, __) =>
                    const Divider(color: AppColor.textMuted, height: 1),
                itemBuilder: (context, index) {
                  return _RecipeRow(
                    recipe: _filteredRecipes[index],
                    game: widget.game,
                    onCombine: () {
                      widget.game.doCombine(_filteredRecipes[index]);
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 등급 필터 탭 버튼
class _FilterTab extends StatelessWidget {
  final String label;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _FilterTab({
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: selected
                ? color.withValues(alpha: 0.25)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: selected ? color : AppColor.textMuted,
              width: selected ? 1.5 : 0.5,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: selected ? color : AppColor.textSecondary,
              fontSize: 11,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

/// 레시피 한 줄 — [재료1] + [재료2] → [결과]  [조합 버튼]
class _RecipeRow extends StatelessWidget {
  final RecipeData recipe;
  final EmotionDefenseGame game;
  final VoidCallback onCombine;

  const _RecipeRow({
    required this.recipe,
    required this.game,
    required this.onCombine,
  });

  @override
  Widget build(BuildContext context) {
    final ownedIds = game.combineSystem.getOwnedCharacterIds();
    final canCombine = game.combineSystem.canCombine(recipe);

    // 재료별 보유 여부 확인
    final remaining = List<String>.from(ownedIds);
    final materialOwned = <bool>[];
    for (final matId in recipe.materialIds) {
      final has = remaining.remove(matId);
      materialOwned.add(has);
    }

    final resultData = allCharacters[recipe.resultId];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 재료 표시
          Expanded(
            child: Row(
              children: [
                _MaterialChip(
                  name: allCharacters[recipe.materialIds[0]]?.name ?? '?',
                  owned: materialOwned[0],
                  gradeColor: _gradeColor(
                    allCharacters[recipe.materialIds[0]]?.grade,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '+',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                _MaterialChip(
                  name: allCharacters[recipe.materialIds[1]]?.name ?? '?',
                  owned: materialOwned[1],
                  gradeColor: _gradeColor(
                    allCharacters[recipe.materialIds[1]]?.grade,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    '→',
                    style: TextStyle(
                      color: AppColor.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  resultData?.name ?? '?',
                  style: AppTextStyle.hudLabel.copyWith(
                    color: _gradeColor(resultData?.grade),
                  ),
                ),
              ],
            ),
          ),
          // 조합 버튼
          GestureDetector(
            onTap: canCombine ? onCombine : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: canCombine ? AppColor.success : AppColor.disabled,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '조합',
                style: AppTextStyle.buttonSmall.copyWith(
                  color: canCombine
                      ? AppColor.textPrimary
                      : AppColor.textDisabled,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 재료 칩 위젯 — 등급 색상 텍스트 + 보유 여부 테두리
class _MaterialChip extends StatelessWidget {
  final String name;
  final bool owned;
  final Color gradeColor;

  const _MaterialChip({
    required this.name,
    required this.owned,
    required this.gradeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(
          color: owned ? AppColor.success : AppColor.danger,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        name,
        style: TextStyle(
          color: gradeColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
