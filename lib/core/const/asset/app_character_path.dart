/// 캐릭터 이미지 에셋 경로
abstract class AppCharacterPath {
  static const _base = 'assets/images/characters';

  // 일반 등급
  static const String joy = '$_base/joy.webp';
  static const String sadness = '$_base/sadness.webp';
  static const String fear = '$_base/fear.webp';
  static const String surprise = '$_base/surprise.webp';
  static const String loneliness = '$_base/loneliness.webp';
  static const String excitement = '$_base/excitement.webp';

  // 레어 등급
  static const String anger = '$_base/anger.webp';
  static const String jealousy = '$_base/jealousy.webp';
  static const String anxiety = '$_base/anxiety.webp';
  static const String nostalgia = '$_base/nostalgia.webp';
  static const String shame = '$_base/shame.webp';
  static const String gratitude = '$_base/gratitude.webp';

  // 영웅 등급
  static const String madness = '$_base/madness.webp';
  static const String resignation = '$_base/resignation.webp';
  static const String hope = '$_base/hope.webp';
  static const String contempt = '$_base/contempt.webp';
  static const String serenity = '$_base/serenity.webp';
  static const String dread = '$_base/dread.webp';

  // 전설 등급
  static const String passion = '$_base/passion.webp';
  static const String voidChar = '$_base/void_char.webp';
  static const String enlightenment = '$_base/enlightenment.webp';
  static const String love = '$_base/love.webp';

  /// Flame 엔진용 경로 변환 (assets/images/ 접두사 제거)
  static String toFlamePath(String assetPath) =>
      assetPath.replaceFirst('assets/images/', '');
}
