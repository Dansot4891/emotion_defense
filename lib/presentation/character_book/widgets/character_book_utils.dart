import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../data/models/character_model.dart';

/// 등급 색상
Color gradeColor(Grade grade) {
  switch (grade) {
    case Grade.common:
      return AppColor.gradeCommon;
    case Grade.rare:
      return AppColor.gradeRare;
    case Grade.hero:
      return AppColor.gradeHero;
    case Grade.legend:
      return AppColor.gradeLegend;
  }
}

/// 극성 이름
String polarityName(Polarity p) {
  switch (p) {
    case Polarity.positive:
      return '긍정';
    case Polarity.negative:
      return '부정';
    case Polarity.neutral:
      return '중립';
  }
}

/// 극성 색상
Color polarityColor(Polarity p) {
  switch (p) {
    case Polarity.positive:
      return AppColor.success;
    case Polarity.negative:
      return AppColor.danger;
    case Polarity.neutral:
      return AppColor.warning;
  }
}

/// 역할 이름
String roleName(Role r) {
  switch (r) {
    case Role.dealer:
      return '딜러';
    case Role.stunner:
      return '스터너';
    case Role.buffer:
      return '버퍼';
    case Role.debuffer:
      return '디버퍼';
  }
}
