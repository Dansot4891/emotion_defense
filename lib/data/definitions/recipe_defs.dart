import '../models/recipe_model.dart';

/// 레어 캐릭터 조합법 6종
const List<RecipeData> rareRecipes = [
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

/// 영웅 캐릭터 조합법 6종
const List<RecipeData> heroRecipes = [
  RecipeData(
    resultId: 'madness',
    materialIds: ['anger', 'jealousy'],
    description: '분노 + 질투 → 광기',
  ),
  RecipeData(
    resultId: 'resignation',
    materialIds: ['shame', 'nostalgia'],
    description: '수치심 + 그리움 → 체념',
  ),
  RecipeData(
    resultId: 'hope',
    materialIds: ['gratitude', 'anxiety'],
    description: '감사 + 불안 → 희망',
  ),
  RecipeData(
    resultId: 'contempt',
    materialIds: ['shame', 'anger'],
    description: '수치심 + 분노 → 경멸',
  ),
  RecipeData(
    resultId: 'serenity',
    materialIds: ['gratitude', 'nostalgia'],
    description: '감사 + 그리움 → 평온',
  ),
  RecipeData(
    resultId: 'dread',
    materialIds: ['jealousy', 'anxiety'],
    description: '질투 + 불안 → 공포',
  ),
];

/// 전설 캐릭터 조합법 4종
const List<RecipeData> legendRecipes = [
  RecipeData(
    resultId: 'passion',
    materialIds: ['madness', 'hope'],
    description: '광기 + 희망 → 열정',
  ),
  RecipeData(
    resultId: 'void_char',
    materialIds: ['resignation', 'dread'],
    description: '체념 + 공포 → 공허',
  ),
  RecipeData(
    resultId: 'enlightenment',
    materialIds: ['contempt', 'serenity'],
    description: '경멸 + 평온 → 깨달음',
  ),
  RecipeData(
    resultId: 'love',
    materialIds: ['serenity', 'hope'],
    description: '평온 + 희망 → 사랑',
  ),
];

/// 전체 레시피 (조합표에서 표시)
const List<RecipeData> allRecipes = [
  ...rareRecipes,
  ...heroRecipes,
  ...legendRecipes,
];
