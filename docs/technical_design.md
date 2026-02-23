# 감정디펜스 - 기술 설계 문서

## 1. 기술 스택

| 항목 | 기술 |
|------|------|
| 프레임워크 | Flutter |
| 게임 엔진 | Flame (2D) |
| 상태관리 | Flame 내장 또는 Riverpod/Bloc |
| UI (비게임) | Flutter 위젯 (조합표, 보상 선택 등) |
| 데이터 관리 | Dart 클래스 기반 (const 정의, JSON 불필요) |
| 광고 | Google AdMob (google_mobile_ads 패키지) |
| 서버 | 없음 (로컬 전용, 싱글 플레이) |

## 2. 서버 & 네트워크 방침
- **현재 버전은 완전 로컬(오프라인) 게임** — 서버 불필요
- 게임 데이터(캐릭터, 조합표, 웨이브)는 Dart 클래스로 앱 내 직접 정의
- 게임 로직(전투, 조합, 시너지)은 전부 클라이언트에서 처리
- 게임 상태(골드, 배치)는 메모리에서 관리, 한 판 끝나면 리셋
- **광고만 네트워크 필요** (AdMob)
- 향후 확장 시 Firebase 등으로 랭킹/유저 데이터 추가 가능

## 3. 폴더 구조 (게임 개발 컨벤션 기반)

Unity 2D 게임의 레이어 기반 구조를 Flame에 맞게 적용.
시스템끼리 서로 많이 엮이는 게임 특성상 Core/Gameplay/UI/Data 레이어로 분리.

```
lib/
├── main.dart                        # 앱 진입점
│
├── core/                            # 게임 코어 (매니저, 상태, 상수)
│   ├── emotion_defense_game.dart    #   FlameGame 메인 클래스
│   ├── game_state.dart              #   게임 상태 관리 (웨이브, 골드, 게임오버 판정)
│   └── constants.dart               #   게임 상수 (맵 크기, 밸런스 수치 등)
│
├── gameplay/                        # 게임플레이 (컴포넌트 + 시스템)
│   ├── components/                  #   게임 오브젝트 (Flame Component)
│   │   ├── character.dart           #     감정 캐릭터 (배치, 공격, 특수능력)
│   │   ├── enemy.dart               #     적 (이동, HP, 사망 처리)
│   │   ├── projectile.dart          #     투사체 (이동, 충돌 판정)
│   │   └── tile.dart                #     격자 칸 (배치 가능/불가, 경로)
│   ├── systems/                     #   게임 로직 시스템
│   │   ├── wave_system.dart         #     웨이브 관리 (적 스폰, 웨이브 진행)
│   │   ├── combat_system.dart       #     전투 (데미지 계산, 사거리 감지)
│   │   ├── synergy_system.dart      #     시너지 (극성/역할군 조건 체크, 버프 적용)
│   │   ├── combine_system.dart      #     조합 (레시피 매칭, 재료 소멸, 캐릭터 생성)
│   │   ├── gacha_system.dart        #     뽑기 (랜덤 일반 캐릭터 생성, 배치)
│   │   ├── upgrade_system.dart      #     강화 (공격력/공속 업그레이드, 비용 계산)
│   │   ├── economy_system.dart      #     경제 (골드 수입/지출 관리)
│   │   └── reward_system.dart       #     보상 (5라운드 보상 선택지 생성)
│   └── map/                         #   맵 관련
│       ├── grid_map.dart            #     격자 맵 렌더링 (6x10)
│       └── path_system.dart         #     적 이동 경로 정의 및 관리
│
├── ui/                              # UI (Flutter 위젯, 오버레이)
│   ├── screens/                     #   전체 화면
│   │   ├── title_screen.dart        #     타이틀/시작 화면
│   │   ├── game_screen.dart         #     메인 게임 화면 (Flame GameWidget 포함)
│   │   └── game_over_screen.dart    #     게임오버 화면
│   ├── overlays/                    #   게임 중 오버레이 (Flame Overlay)
│   │   ├── hud_overlay.dart         #     상단 HUD (웨이브, 골드, 설정)
│   │   ├── action_bar.dart          #     하단 액션 버튼 (뽑기, 조합, 강화, 판매)
│   │   ├── combine_popup.dart       #     조합표 팝업
│   │   ├── reward_popup.dart        #     5라운드 보상 선택 팝업
│   │   └── character_info.dart      #     캐릭터 정보/강화 패널
│   └── widgets/                     #   공통 위젯
│       └── common_button.dart       #     재사용 가능한 공통 UI 컴포넌트
│
├── data/                            # 데이터 (모델 + 게임 데이터 정의)
│   ├── models/                      #   데이터 모델 (Dart 클래스)
│   │   ├── character_model.dart     #     캐릭터 모델 (id, 이름, 등급, 극성, 역할, 스탯)
│   │   ├── enemy_model.dart         #     적 모델 (id, HP, 속도, 보상, 특수능력)
│   │   ├── recipe_model.dart        #     조합 레시피 모델 (재료, 결과)
│   │   └── wave_model.dart          #     웨이브 모델 (적 구성, 보상)
│   └── definitions/                 #   게임 데이터 정의 (Dart const)
│       ├── character_defs.dart      #     전체 캐릭터 데이터 정의
│       ├── recipe_defs.dart         #     조합 레시피 데이터 정의
│       ├── wave_defs.dart           #     30웨이브 적 구성 데이터 정의
│       ├── enemy_defs.dart          #     적 종류 데이터 정의
│       └── upgrade_defs.dart        #     강화 비용/효과 테이블 정의
│
├── ads/                             # 광고 (AdMob)
│   ├── ad_manager.dart              #   광고 초기화, 로드, 표시 관리
│   └── ad_config.dart               #   광고 ID, 설정값
│
└── assets/                          # 리소스
    ├── sprites/                     #   캐릭터, 적, 투사체, 타일 스프라이트
    ├── audio/                       #   효과음, BGM
    └── fonts/                       #   커스텀 폰트
```

## 4. 광고 시스템 (AdMob)

| 항목 | 설명 |
|------|------|
| **광고 SDK** | Google AdMob (`google_mobile_ads` 패키지) |
| **전면광고 (Interstitial)** | 게임오버 시 표시, 30웨이브 클리어 시 표시 |
| **배너광고 (Banner)** | 타이틀 화면 하단 (선택사항) |
| **보상형광고 (Rewarded)** | 선택사항 - 광고 시청 시 보너스 골드 또는 추가 뽑기 |

### 광고 타이밍
- **게임오버 → 전면광고 → 결과 화면**
- **30웨이브 클리어 → 결과 화면 → 전면광고**
- **게임 중에는 광고 노출하지 않음** (플레이 방해 금지)
- 보상형 광고는 웨이브 준비 시간 중 선택적으로 시청 가능

## 5. 클래스 설계 (추상 클래스 + Mixin)

역할(존재 자체)은 **추상 클래스**로, 능력(붙였다 뗐다)은 **Mixin**으로 설계.
캐릭터가 여러 능력을 동시에 가질 수 있으므로 Mixin 방식이 적합.

### 추상 클래스 (역할 계층)
```dart
// 최상위 게임 엔티티
abstract class BaseEntity {
  Vector2 position;       // 격자 위치
}

// 아군 캐릭터 (감정)
abstract class BaseCharacter extends BaseEntity {
  String id;              // 캐릭터 고유 ID
  String name;            // 이름
  Grade grade;            // 등급 (common, rare, hero, legend)
  Polarity polarity;      // 극성 (positive, negative, neutral)
  double atk;             // 공격력
  double aspd;            // 공격속도
  int range;              // 사거리 (칸 단위, 고정)
  int upgradeLevel;       // 강화 단계

  void attack(BaseEnemy target);  // 평타 (모든 캐릭터 기본)
}

// 적 (공허)
abstract class BaseEnemy extends BaseEntity {
  double hp;              // 체력
  double maxHp;           // 최대 체력
  double def;             // 방어력
  double speed;           // 이동속도
  int rewardGold;         // 처치 보상 골드

  void moveAlongPath();   // 경로 따라 이동
  void takeDamage(double damage);  // 데미지 처리
}

// 보스 (적의 확장)
abstract class BaseBoss extends BaseEnemy {
  List<BossSkill> skills; // 보스 전용 스킬
  int phase;              // 현재 페이즈

  void activateSkill();   // 스킬 발동
}
```

### Mixin (능력 — 선택적 부착)
```dart
// 패시브: 존재만으로 주변에 영향 (오라)
mixin PassiveAura {
  double auraRange;       // 오라 범위 (칸)
  AuraEffect auraEffect;  // 효과 종류 (아군버프/적디버프)
  double auraValue;       // 효과 수치

  void applyAura();       // 범위 내 대상에게 효과 적용
}

// 액티브: 평타 시 확률 발동 추가 효과
mixin ActiveOnHit {
  double procChance;      // 발동 확률 (0.0~1.0)
  ActiveEffect effect;    // 효과 종류 (크리티컬/스턴/감속/방깎/범위)
  double effectValue;     // 효과 수치
  double effectDuration;  // 효과 지속시간 (초)

  void onHitProc(BaseEnemy target);  // 평타 적중 시 확률 판정 → 효과 적용
}

// 분열 (적 전용)
mixin Splittable {
  int splitCount;         // 분열 수
  String splitInto;       // 분열 후 적 타입

  void onDeath();         // 사망 시 분열
}
```

### 실제 캐릭터 조합 예시
```dart
// 일반: 평타만
class Joy extends BaseCharacter { }
class Sadness extends BaseCharacter { }

// 레어: 평타 + 능력 1개
class Anger extends BaseCharacter with ActiveOnHit { }      // 평타 크리티컬
class Yearning extends BaseCharacter with PassiveAura { }   // 아군 공격력 오라

// 영웅: 평타 + 능력 2개 (자유 조합)
class Hope extends BaseCharacter with PassiveAura { }       // 패시브 2개 (다중 오라)
class Contempt extends BaseCharacter with ActiveOnHit { }   // 액티브 2개 (다중 확률효과)
class Madness extends BaseCharacter with PassiveAura, ActiveOnHit { }  // 패시브+액티브

// 전설: 평타 + 능력 2~3개 (자유 조합)
class Passion extends BaseCharacter with PassiveAura, ActiveOnHit { }  // 패시브+액티브 복수
class Void extends BaseCharacter with PassiveAura, ActiveOnHit { }     // 디버프+CC 복합

// 적
class IdleThought extends BaseEnemy { }                     // 일반 적
class Burnout extends BaseEnemy with Splittable { }         // 분열 적
class VoidBoss extends BaseBoss { }                         // 보스
```

> **참고:** 패시브/액티브를 여러 개 가진 캐릭터는 동일 Mixin을 1개만 붙이되, 내부에 `List<PassiveEffect>` / `List<ActiveEffect>`로 복수 효과를 관리합니다.

## 6. 데이터 구조 예시

로컬 전용 싱글 플레이이므로 JSON 파일 없이 **Dart 클래스로 직접 정의**.
타입 안전성, IDE 자동완성, 파싱 코드 불필요 등의 이점.

### 모델 클래스 예시

```dart
// data/models/character_model.dart
enum Grade { common, rare, hero, legend }
enum Polarity { positive, negative, neutral }
enum Role { dealer, stunner, buffer, debuffer }

// 패시브 효과 정의
class PassiveData {
  final String type;          // ally_atk_buff, ally_aspd_buff, enemy_spd_debuff, enemy_def_debuff
  final int range;            // 오라 범위 (칸)
  final double value;         // 효과 수치
  final String description;

  const PassiveData({
    required this.type,
    required this.range,
    required this.value,
    required this.description,
  });
}

// 액티브 효과 정의
class ActiveData {
  final String type;          // critical, stun, slow, def_break, aoe_damage
  final double procChance;    // 발동 확률 (0.0~1.0)
  final double value;         // 효과 수치
  final double duration;      // 지속시간 (초, 0이면 즉발)
  final String description;

  const ActiveData({
    required this.type,
    required this.procChance,
    required this.value,
    required this.duration,
    required this.description,
  });
}

class CharacterData {
  final String id;
  final String name;
  final Grade grade;
  final Polarity polarity;
  final Role role;
  final double atk;
  final double aspd;
  final int range;
  final List<PassiveData> passives;   // 패시브 스킬 목록 (0~2개)
  final List<ActiveData> actives;     // 액티브 스킬 목록 (0~2개)
  final String description;

  const CharacterData({
    required this.id,
    required this.name,
    required this.grade,
    required this.polarity,
    required this.role,
    required this.atk,
    required this.aspd,
    required this.range,
    this.passives = const [],
    this.actives = const [],
    required this.description,
  });
}
```

### 데이터 정의 예시

```dart
// data/definitions/character_defs.dart
const allCharacters = [
  // 일반: 평타만
  CharacterData(
    id: 'joy',
    name: '기쁨',
    grade: Grade.common,
    polarity: Polarity.positive,
    role: Role.dealer,
    atk: 10, aspd: 1.0, range: 2,
    passives: [],
    actives: [],
    description: '기본적인 행복의 감정',
  ),

  // 레어: 능력 1개
  CharacterData(
    id: 'anger',
    name: '분노',
    grade: Grade.rare,
    polarity: Polarity.negative,
    role: Role.dealer,
    atk: 25, aspd: 0.8, range: 2,
    passives: [],
    actives: [
      ActiveData(type: 'critical', procChance: 0.15, value: 2.0, duration: 0,
        description: '평타 시 15% 확률로 2배 데미지'),
    ],
    description: '슬픔과 외로움이 만나 분노가 된다',
  ),

  // 영웅: 능력 2개 (패시브 2개 - 순수 버퍼)
  CharacterData(
    id: 'hope',
    name: '희망',
    grade: Grade.hero,
    polarity: Polarity.positive,
    role: Role.buffer,
    atk: 40, aspd: 1.2, range: 2,
    passives: [
      PassiveData(type: 'ally_atk_buff', range: 1, value: 0.15,
        description: '주변 1칸 아군 공격력 +15%'),
      PassiveData(type: 'ally_aspd_buff', range: 1, value: 0.10,
        description: '주변 1칸 아군 공격속도 +10%'),
    ],
    actives: [],
    description: '기쁨과 그리움이 만나 희망이 된다',
  ),

  // 전설: 능력 3개 (패시브 1 + 액티브 2)
  CharacterData(
    id: 'passion',
    name: '열정',
    grade: Grade.legend,
    polarity: Polarity.positive,
    role: Role.dealer,
    atk: 120, aspd: 0.6, range: 3,
    passives: [
      PassiveData(type: 'ally_aspd_buff', range: 2, value: 0.10,
        description: '주변 2칸 아군 공격속도 +10%'),
    ],
    actives: [
      ActiveData(type: 'critical', procChance: 0.20, value: 2.5, duration: 0,
        description: '평타 시 20% 확률로 2.5배 데미지'),
      ActiveData(type: 'aoe_damage', procChance: 0.10, value: 0.5, duration: 0,
        description: '평타 시 10% 확률로 주변 적에게 50% 범위 데미지'),
    ],
    description: '광기와 희망이 만나 열정이 된다',
  ),
];
```

```dart
// data/definitions/recipe_defs.dart
class RecipeData {
  final String resultId;
  final List<String> materialIds;
  final String description;

  const RecipeData({
    required this.resultId,
    required this.materialIds,
    required this.description,
  });
}

const allRecipes = [
  RecipeData(
    resultId: 'anger',
    materialIds: ['sadness', 'loneliness'],
    description: '슬픔과 외로움이 만나 분노가 된다',
  ),
  // ... 나머지 조합법
];
```

```dart
// data/definitions/wave_defs.dart
class WaveData {
  final int wave;
  final List<EnemySpawn> enemies;
  final int clearGold;
  final int autoGold;

  const WaveData({
    required this.wave,
    required this.enemies,
    required this.clearGold,
    required this.autoGold,
  });
}

class EnemySpawn {
  final String enemyId;
  final int count;
  final double delay;

  const EnemySpawn({
    required this.enemyId,
    required this.count,
    required this.delay,
  });
}

const allWaves = [
  WaveData(
    wave: 1,
    enemies: [EnemySpawn(enemyId: 'idle_thought', count: 5, delay: 1.0)],
    clearGold: 20,
    autoGold: 30,
  ),
  // ... 나머지 웨이브
];
```

## 7. 핵심 게임 루프 (Flame)
```
FlameGame.update(dt) 매 프레임 호출:
  1. WaveSystem: 현재 웨이브의 적 스폰 관리
  2. Enemy.update: 경로를 따라 이동
  3. Character.update: 사거리 내 적 감지 → 공격
  4. Projectile.update: 투사체 이동 → 충돌 판정
  5. CombatSystem: 데미지 적용, 특수능력 처리
  6. SynergySystem: 시너지 조건 체크 → 버프/디버프 적용
  7. EconomySystem: 골드 변동 처리
  8. GameState: 게임오버/웨이브 클리어 판정
```

## 8. 개발 우선순위

### Phase 1 - 코어 프로토타입
1. 격자 맵 렌더링 + 경로 시스템
2. 적 스폰 및 경로 이동
3. 기본 캐릭터 배치 + 자동 공격
4. 투사체 + 충돌 판정
5. 골드 시스템 (뽑기/처치 보상)

### Phase 2 - 조합 & 등급
6. 조합표 UI + 조합 시스템
7. 4등급 캐릭터 전체 구현
8. 캐릭터 판매 시스템

### Phase 3 - 전투 심화
9. 역할군 특수능력 (스턴/버프/디버프)
10. 시너지 시스템 (극성 + 역할군)
11. 강화 시스템

### Phase 4 - 게임 완성
12. 30웨이브 전체 구성
13. 5라운드 보상 시스템
14. 적 종류 다양화 (특수 적, 보스)
15. UI 폴리싱 + 밸런스 조정
