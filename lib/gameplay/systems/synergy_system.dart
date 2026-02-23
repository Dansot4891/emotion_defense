import '../../data/models/character_model.dart';
import '../components/character.dart';

/// 시너지 보너스 결과
class SynergyBonuses {
  final double allyAtkBonus; // 아군 ATK 보너스 비율
  final double allyAspdBonus; // 아군 ASPD 보너스 비율
  final double enemySpeedPenalty; // 적 이동속도 감소 비율
  final double enemyDefPenalty; // 적 방어력 감소 수치
  final bool emotionExplosion; // 감정폭발 활성 여부
  final double dealerCritBonus; // 딜러 크리티컬 보너스
  final double stunDurationBonus; // 스턴 지속시간 보너스
  final double bufferRangeBonus; // 버퍼 오라 범위 보너스 (칸)
  final double debufferDurationBonus; // 디버퍼 효과 지속시간 보너스

  const SynergyBonuses({
    this.allyAtkBonus = 0,
    this.allyAspdBonus = 0,
    this.enemySpeedPenalty = 0,
    this.enemyDefPenalty = 0,
    this.emotionExplosion = false,
    this.dealerCritBonus = 0,
    this.stunDurationBonus = 0,
    this.bufferRangeBonus = 0,
    this.debufferDurationBonus = 0,
  });
}

/// 시너지 시스템 — 극성/역할군 시너지 계산
class SynergySystem {
  const SynergySystem();

  /// 현재 배치된 캐릭터들로 시너지 보너스 계산
  SynergyBonuses calculate(List<CharacterComponent> characters) {
    // 극성 카운트
    int positiveCount = 0;
    int negativeCount = 0;

    // 역할군 카운트
    int dealerCount = 0;
    int stunnerCount = 0;
    int bufferCount = 0;
    int debufferCount = 0;

    for (final char in characters) {
      // 극성
      switch (char.data.polarity) {
        case Polarity.positive:
          positiveCount++;
          break;
        case Polarity.negative:
          negativeCount++;
          break;
        case Polarity.neutral:
          break;
      }

      // 역할군
      switch (char.data.role) {
        case Role.dealer:
          dealerCount++;
          break;
        case Role.stunner:
          stunnerCount++;
          break;
        case Role.buffer:
          bufferCount++;
          break;
        case Role.debuffer:
          debufferCount++;
          break;
      }
    }

    double allyAtkBonus = 0;
    double allyAspdBonus = 0;
    double enemySpeedPenalty = 0;
    double enemyDefPenalty = 0;
    bool emotionExplosion = false;
    double dealerCritBonus = 0;
    double stunDurationBonus = 0;
    double bufferRangeBonus = 0;
    double debufferDurationBonus = 0;

    // === 극성 시너지 ===
    // Positive 3+ → 아군 ATK +10%
    if (positiveCount >= 3) allyAtkBonus += 0.10;
    // Positive 5+ → 아군 ATK +20%, ASPD +10%
    if (positiveCount >= 5) {
      allyAtkBonus += 0.10;
      allyAspdBonus += 0.10;
    }
    // Negative 3+ → 적 이동속도 -10%
    if (negativeCount >= 3) enemySpeedPenalty += 0.10;
    // Negative 5+ → 적 이동속도 -20%, 방깎 +2
    if (negativeCount >= 5) {
      enemySpeedPenalty += 0.10;
      enemyDefPenalty += 2;
    }
    // 감정폭발: Positive 3+ AND Negative 3+
    if (positiveCount >= 3 && negativeCount >= 3) {
      emotionExplosion = true;
    }

    // === 역할군 시너지 ===
    // 딜러 3+ → 크리티컬 보너스 +0.15
    if (dealerCount >= 3) dealerCritBonus += 0.15;
    // 스터너 2+ → 스턴 지속시간 +0.5s
    if (stunnerCount >= 2) stunDurationBonus += 0.5;
    // 버퍼 2+ → 오라 범위 +1칸
    if (bufferCount >= 2) bufferRangeBonus += 1;
    // 디버퍼 2+ → 디버프 지속시간 +1s
    if (debufferCount >= 2) debufferDurationBonus += 1.0;

    return SynergyBonuses(
      allyAtkBonus: allyAtkBonus,
      allyAspdBonus: allyAspdBonus,
      enemySpeedPenalty: enemySpeedPenalty,
      enemyDefPenalty: enemyDefPenalty,
      emotionExplosion: emotionExplosion,
      dealerCritBonus: dealerCritBonus,
      stunDurationBonus: stunDurationBonus,
      bufferRangeBonus: bufferRangeBonus,
      debufferDurationBonus: debufferDurationBonus,
    );
  }
}
