# 사운드 설계

## 개요
감정디펜스 게임 내 효과음(SFX) 및 배경음악(BGM) 구현 가이드.

## SFX 목록 (17종)

### 전투 (3종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 1 | `attack` | `attack.mp3` | 투사체 발사음 | 짧고 가벼운 "슝" 느낌 | ✅
| 2 | `hit` | `hit.mp3` | 적 피격음 | 타격감 있는 "퍽" |
| 3 | `kill` | `kill.mp3` | 적 처치음 | 터지는 느낌 "펑" | ✅

### 경제/시스템 (8종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 4 | `gold` | `gold.mp3` | 골드 획득 | 코인 소리 |
| 5 | `gacha` | `gacha.mp3` | 가챠(소환) | 간단하게 소환되는 소리 |
| 6 | `place` | `place.mp3` | 캐릭터 배치 | 타일에 놓는 "톡" |
| 7 | `sell` | `sell.mp3` | 캐릭터 판매 | 회수/사라지는 효과음 |
| 8 | `combine` | `combine.mp3` | 조합 성공 | 등급업 느낌의 상승음 |
| 9 | `combine_legendary` | `combine_legendary.mp3` | 전설 조합 연출 | 특별한 팡파레 + 반짝임 |
| 10 | `change` | `change.mp3` | 캐릭터 교체 | 교체/리롤 시 효과음 |
| 11 | `upgrade` | `upgrade.mp3` | 강화 성공 | 파워업 상승음 |

### 웨이브 (4종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 12 | `wave_start` | `wave_start.mp3` | 웨이브 시작 | 경고/알림 사이렌(너무 크면 안됨) |
| 13 | `boss_spawn` | `boss_spawn.mp3` | 보스 등장 | 묵직한 긴장감 |
| 14 | `wave_clear` | `wave_clear.mp3` | 웨이브 클리어 | 짧은 팡파레 |
| 15 | `base_hit` | `base_hit.mp3` | 기지 피격 | 위험 알림음 |

### UI (2종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 16 | `button_tap` | `button_tap.mp3` | 버튼 터치 | 가벼운 클릭음 |
| 17 | `game_over` | `game_over.mp3` | 게임오버 | 패배 연출음 |

## 에셋 경로
```
assets/
└── audio/
    └── sfx/
        ├── attack.mp3
        ├── hit.mp3
        ├── kill.mp3
        ├── gold.mp3
        ├── gacha.mp3
        ├── place.mp3
        ├── sell.mp3
        ├── combine.mp3
        ├── combine_legendary.mp3
        ├── change.mp3
        ├── upgrade.mp3
        ├── wave_start.mp3
        ├── boss_spawn.mp3
        ├── wave_clear.mp3
        ├── base_hit.mp3
        ├── button_tap.mp3
        └── game_over.mp3
```

## BGM 목록 (2곡)

| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 1 | `title` | `bgm/title.mp3` | 타이틀 화면 | 밝고 가벼운 루프, 게임 분위기 소개 |
| 2 | `ingame` | `bgm/ingame.mp3` | 인게임 (웨이브 진행) | 긴장감 있는 루프, 전투 분위기 |

### BGM 에셋 경로
```
assets/
└── audio/
    └── bgm/
        ├── title.mp3
        └── ingame.mp3
```

### BGM 재생 규칙
- 타이틀 화면 진입 → `title` 루프 재생
- 게임 시작 (첫 웨이브 시작 or 게임 화면 진입) → `ingame`으로 전환
- 게임오버/승리 → BGM 정지
- 타이틀로 복귀 → `title` 재개
- 볼륨: SFX와 별도로 조절 가능

## 파일 규격
- **포맷:** MP3 (용량 절감) 또는 OGG
- **샘플레이트:** 44100Hz
- **길이:** SFX는 0.3~2초 이내 / BGM은 30초~2분 루프
- **볼륨:** 피크 -3dB 이하로 정규화 (BGM은 SFX보다 낮게)

## 소스
- **Pixabay** (pixabay.com/sound-effects) — 상업용 무료, 출처 표기 불필요
- **Kenney** (kenney.nl) — 게임 특화 CC0 에셋
- **ElevenLabs Sound Effects** — AI 텍스트 기반 SFX 생성

## 향후 추가 예정
| 카테고리 | 항목 |
|---|---|
| 전투 SFX | 크리티컬 타격, 스턴 적용, AoE 폭발, 감속/버프/방깎 이펙트 |
| BGM | 보스전, 게임오버 |
