import 'dart:ui';

import 'effect_model.dart';

/// 캐릭터 등급
enum Grade { common, rare, hero, legend }

/// 감정 극성
enum Polarity { positive, negative, neutral }

/// 역할군
enum Role { dealer, stunner, buffer, debuffer }

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
    required this.description,
    this.passives = const [],
    this.actives = const [],
  });
}
