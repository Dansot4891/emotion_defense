# 감정디펜스 (Emotion Defense)

> 랜덤 조합 타워디펜스 | Flutter + Flame Engine | 모바일 (세로 모드)

## 기술 스택
- **프레임워크:** Flutter + Flame (2D 게임 엔진)
- **상태관리:** Flame 내장 또는 Riverpod/Bloc
- **UI:** 게임 = Flame Component, 비게임(조합표/보상 등) = Flutter 위젯 (Flame Overlay)
- **데이터:** Dart 클래스 기반 const 정의 (JSON 불필요, 로컬 전용)
- **광고:** Google AdMob (google_mobile_ads)
- **서버:** 없음 (완전 오프라인 싱글 플레이)

## 코딩 컨벤션
- 역할(존재 자체)은 **추상 클래스**, 능력(붙였다 뗐다)은 **Mixin**으로 설계
- 복수 패시브/액티브는 Mixin 1개 + 내부 `List<Effect>`로 관리
- 게임 데이터는 `data/definitions/`에 Dart const로 정의
- 한국어 주석 사용

## 폴더 구조
```
lib/
├── main.dart                     # 앱 진입점
├── core/                         # 게임 코어 (FlameGame, 상태, 상수)
│   ├── emotion_defense_game.dart
│   ├── game_state.dart
│   └── constants.dart
├── gameplay/                     # 게임플레이 (컴포넌트 + 시스템)
│   ├── components/               #   character, enemy, projectile, tile
│   ├── systems/                  #   wave, combat, synergy, combine, gacha, upgrade, economy, reward
│   └── map/                      #   grid_map, path_system
├── ui/                           # UI (Flutter 위젯)
│   ├── screens/                  #   title, game, game_over
│   ├── overlays/                 #   hud, action_bar, combine_popup, reward_popup, character_info
│   └── widgets/                  #   공통 위젯
├── data/                         # 데이터
│   ├── models/                   #   character_model, enemy_model, recipe_model, wave_model
│   └── definitions/              #   character_defs, recipe_defs, wave_defs, enemy_defs, upgrade_defs
└── ads/                          # 광고 (AdMob)
    ├── ad_manager.dart
    └── ad_config.dart
```

## 핵심 게임 루프
```
FlameGame.update(dt):
  WaveSystem → Enemy.update → Character.update → Projectile.update
  → CombatSystem → SynergySystem → EconomySystem → GameState 판정
```

## 개발 단계
- **Phase 1 (코어):** 격자 맵, 경로, 적 이동, 캐릭터 배치/공격, 투사체, 골드
- **Phase 2 (조합):** 조합표 UI, 4등급 캐릭터, 판매
- **Phase 3 (전투 심화):** 스킬(스턴/버프/디버프), 시너지, 강화
- **Phase 4 (완성):** 30웨이브, 보상, 적 다양화, UI 폴리싱

## 상세 문서
- **[docs/game_design.md](docs/game_design.md)** — 전체 게임 기획서 (캐릭터, 조합, 전투, 시너지, 경제, 웨이브, UI 등)
- **[docs/technical_design.md](docs/technical_design.md)** — 기술 설계 상세 (클래스 구조, 데이터 모델, 코드 예시, 광고)
