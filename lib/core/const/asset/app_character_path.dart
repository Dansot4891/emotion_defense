/// 캐릭터 이미지 에셋 경로
abstract class AppCharacterPath {
  static const _base = 'assets/images/characters';

  // 일반 등급
  static const String joy = '$_base/joy.png';
  static const String sadness = '$_base/sadness.png';
  static const String fear = '$_base/fear.png';
  static const String surprise = '$_base/surprise.png';
  static const String loneliness = '$_base/loneliness.png';
  static const String excitement = '$_base/excitement.png';

  // 레어 등급
  static const String anger = '$_base/anger.png';
  static const String jealousy = '$_base/jealousy.png';
  static const String anxiety = '$_base/anxiety.png';
  static const String nostalgia = '$_base/nostalgia.png';
  static const String shame = '$_base/shame.png';
  static const String gratitude = '$_base/gratitude.png';

  // 영웅 등급
  static const String madness = '$_base/madness.png';
  static const String resignation = '$_base/resignation.png';
  static const String hope = '$_base/hope.png';
  static const String contempt = '$_base/contempt.png';
  static const String serenity = '$_base/serenity.png';
  static const String dread = '$_base/dread.png';

  // 전설 등급
  static const String passion = '$_base/passion.png';
  static const String voidChar = '$_base/void_char.png';
  static const String enlightenment = '$_base/enlightenment.png';
  static const String love = '$_base/love.png';

  /// Flame 엔진용 경로 변환 (assets/images/ 접두사 제거)
  static String toFlamePath(String assetPath) =>
      assetPath.replaceFirst('assets/images/', '');
}
