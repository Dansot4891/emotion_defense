import '../models/recipe_model.dart';

/// 레어 캐릭터 조합법 8종
/// 커먼 사용 균등: 기쁨(2) 슬픔(2) 두려움(2) 놀람(2) 외로움(2) 설렘(2) 혐오(2) 호기심(2)
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
    materialIds: ['fear', 'curiosity'],
    description: '두려움 + 호기심 → 불안',
  ),
  RecipeData(
    resultId: 'nostalgia',
    materialIds: ['sadness', 'excitement'],
    description: '슬픔 + 설렘 → 그리움',
  ),
  RecipeData(
    resultId: 'shame',
    materialIds: ['surprise', 'disgust'],
    description: '놀람 + 혐오 → 수치심',
  ),
  RecipeData(
    resultId: 'gratitude',
    materialIds: ['joy', 'curiosity'],
    description: '기쁨 + 호기심 → 감사',
  ),
  RecipeData(
    resultId: 'regret',
    materialIds: ['loneliness', 'disgust'],
    description: '외로움 + 혐오 → 후회',
  ),
  RecipeData(
    resultId: 'wonder',
    materialIds: ['excitement', 'surprise'],
    description: '설렘 + 놀람 → 경이',
  ),
];

/// 영웅 캐릭터 조합법 8종
/// 레어 사용 균등: 분노(2) 질투(2) 불안(2) 그리움(2) 수치심(2) 감사(2) 후회(2) 경이(2)
const List<RecipeData> heroRecipes = [
  RecipeData(
    resultId: 'madness',
    materialIds: ['anger', 'wonder'],
    description: '분노 + 경이 → 광기',
  ),
  RecipeData(
    resultId: 'resignation',
    materialIds: ['regret', 'anxiety'],
    description: '후회 + 불안 → 체념',
  ),
  RecipeData(
    resultId: 'hope',
    materialIds: ['gratitude', 'nostalgia'],
    description: '감사 + 그리움 → 희망',
  ),
  RecipeData(
    resultId: 'contempt',
    materialIds: ['jealousy', 'shame'],
    description: '질투 + 수치심 → 경멸',
  ),
  RecipeData(
    resultId: 'serenity',
    materialIds: ['gratitude', 'wonder'],
    description: '감사 + 경이 → 평온',
  ),
  RecipeData(
    resultId: 'dread',
    materialIds: ['anger', 'anxiety'],
    description: '분노 + 불안 → 공포',
  ),
  RecipeData(
    resultId: 'obsession',
    materialIds: ['jealousy', 'nostalgia'],
    description: '질투 + 그리움 → 집착',
  ),
  RecipeData(
    resultId: 'courage',
    materialIds: ['shame', 'regret'],
    description: '수치심 + 후회 → 용기',
  ),
];

/// 전설 캐릭터 조합법 6종
/// 영웅 사용: 광기(1) 체념(1) 희망(2) 경멸(2) 평온(2) 공포(1) 집착(1) 용기(2)
const List<RecipeData> legendRecipes = [
  RecipeData(
    resultId: 'passion',
    materialIds: ['madness', 'courage'],
    description: '광기 + 용기 → 열정',
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
    materialIds: ['hope', 'serenity'],
    description: '희망 + 평온 → 사랑',
  ),
  RecipeData(
    resultId: 'vengeance',
    materialIds: ['obsession', 'contempt'],
    description: '집착 + 경멸 → 복수',
  ),
  RecipeData(
    resultId: 'ecstasy',
    materialIds: ['hope', 'courage'],
    description: '희망 + 용기 → 황홀',
  ),
];

/// 전체 레시피 (조합표에서 표시)
const List<RecipeData> allRecipes = [
  ...rareRecipes,
  ...heroRecipes,
  ...legendRecipes,
];
