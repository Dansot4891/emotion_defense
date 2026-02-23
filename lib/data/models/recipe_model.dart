/// 조합법 데이터 정의
class RecipeData {
  final String resultId; // 결과 캐릭터 ID
  final List<String> materialIds; // 재료 캐릭터 ID 2개
  final String description;

  const RecipeData({
    required this.resultId,
    required this.materialIds,
    required this.description,
  });
}
