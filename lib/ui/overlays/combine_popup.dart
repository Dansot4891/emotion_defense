import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/const/style/app_text_style.dart';
import '../../core/emotion_defense_game.dart';
import '../../data/definitions/character_defs.dart';
import '../../data/definitions/recipe_defs.dart';
import '../../data/models/recipe_model.dart';

/// 조합표 팝업 오버레이 — 레시피 목록 + 재료 보유 표시 + 조합 실행
class CombinePopup extends StatefulWidget {
  final EmotionDefenseGame game;

  const CombinePopup({super.key, required this.game});

  @override
  State<CombinePopup> createState() => _CombinePopupState();
}

class _CombinePopupState extends State<CombinePopup> {
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
            const SizedBox(height: 12),
            // 레시피 목록
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: allRecipes.length,
                separatorBuilder: (_, __) => const Divider(
                  color: AppColor.textMuted,
                  height: 1,
                ),
                itemBuilder: (context, index) {
                  return _RecipeRow(
                    recipe: allRecipes[index],
                    game: widget.game,
                    onCombine: () {
                      widget.game.doCombine(allRecipes[index]);
                      setState(() {}); // 조합 후 목록 갱신
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
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text('+',
                      style: TextStyle(
                          color: AppColor.textSecondary, fontSize: 14)),
                ),
                _MaterialChip(
                  name: allCharacters[recipe.materialIds[1]]?.name ?? '?',
                  owned: materialOwned[1],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Text('→',
                      style: TextStyle(
                          color: AppColor.textSecondary, fontSize: 14)),
                ),
                Text(
                  resultData?.name ?? '?',
                  style: AppTextStyle.hudLabel.copyWith(
                    color: resultData?.color ?? AppColor.textPrimary,
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
                  color:
                      canCombine ? AppColor.textPrimary : AppColor.textDisabled,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 재료 칩 위젯 — 보유 시 초록, 미보유 시 빨간색
class _MaterialChip extends StatelessWidget {
  final String name;
  final bool owned;

  const _MaterialChip({required this.name, required this.owned});

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
          color: owned ? AppColor.success : AppColor.danger,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
