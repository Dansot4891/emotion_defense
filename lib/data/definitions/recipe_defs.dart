import '../models/recipe_model.dart';

/// 레어 캐릭터 조합법 6종
const List<RecipeData> allRecipes = [
  RecipeData(
    resultId: 'anger',
    materialIds: ['sadness', 'loneliness'],
    description: '슬픔 + 외로움 → 분노',
  ),
  RecipeData(
    resultId: 'jealousy',
    materialIds: ['joy', 'fear'],
    description: '기쁨 + 두려움 → 질투',
  ),
  RecipeData(
    resultId: 'anxiety',
    materialIds: ['fear', 'surprise'],
    description: '두려움 + 놀람 → 불안',
  ),
  RecipeData(
    resultId: 'nostalgia',
    materialIds: ['sadness', 'excitement'],
    description: '슬픔 + 설렘 → 그리움',
  ),
  RecipeData(
    resultId: 'shame',
    materialIds: ['surprise', 'loneliness'],
    description: '놀람 + 외로움 → 수치심',
  ),
  RecipeData(
    resultId: 'gratitude',
    materialIds: ['joy', 'excitement'],
    description: '기쁨 + 설렘 → 감사',
  ),
];
