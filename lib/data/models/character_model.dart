import 'dart:ui';
import '../../core/const/style/app_color.dart';
import 'effect_model.dart';

/// 캐릭터 등급
enum Grade {
  common('일반', AppColor.gradeCommon),
  rare('레어', AppColor.gradeRare),
  hero('영웅', AppColor.gradeHero),
  legend('전설', AppColor.gradeLegend);

  final String displayName;
  final Color color;

  const Grade(this.displayName, this.color);
}

/// 감정 극성
enum Polarity {
  positive('긍정', AppColor.success),
  negative('부정', AppColor.danger),
  neutral('중립', AppColor.warning);

  final String displayName;
  final Color color;

  const Polarity(this.displayName, this.color);
}

/// 역할군
enum Role {
  dealer('딜러'),
  stunner('스터너'),
  buffer('버퍼'),
  debuffer('디버퍼');

  final String displayName;

  const Role(this.displayName);
}

/// 캐릭터 데이터 정의 (const 불변 데이터)
class CharacterData {
  final String id;
  final String name;
  final Grade grade;
  final Polarity polarity;
  final Role role;
  final double atk;
  final double aspd; // 공격 쿨다운 (초)
  final int range; // 사거리 (칸 단위)
  final int sellValue; // 판매 골드
  final Color color; // 프로토타입용 색상
  final String imagePath; // 캐릭터 이미지 에셋 경로
  final String description;
  final List<PassiveData> passives; // 패시브 스킬 목록
  final List<ActiveData> actives; // 액티브 스킬 목록

  const CharacterData({
    required this.id,
    required this.name,
    required this.grade,
    required this.polarity,
    required this.role,
    required this.atk,
    required this.aspd,
    required this.range,
    required this.sellValue,
    required this.color,
    required this.imagePath,
    required this.description,
    this.passives = const [],
    this.actives = const [],
  });
}
