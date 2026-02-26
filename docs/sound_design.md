# 사운드 설계

## 개요
감정디펜스 게임 내 효과음(SFX) 목록 및 구현 가이드.
BGM은 별도 단계에서 추가 예정.

## SFX 목록 (16종)

### 전투 (3종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 1 | `attack` | `attack.mp3` | 투사체 발사음 | 짧고 가벼운 "슝" 느낌 | ✅
| 2 | `hit` | `hit.mp3` | 적 피격음 | 타격감 있는 "퍽" |
| 3 | `kill` | `kill.mp3` | 적 처치음 | 터지는 느낌 "펑" | ✅

### 경제/시스템 (7종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 4 | `gold` | `gold.mp3` | 골드 획득 | 코인 소리 |
| 5 | `gacha` | `gacha.mp3` | 가챠(소환) | 간단하게 소환되는 소리 |
| 6 | `place` | `place.mp3` | 캐릭터 배치 | 타일에 놓는 "톡" |
| 7 | `sell` | `sell.mp3` | 캐릭터 판매 | 회수/사라지는 효과음 |
| 8 | `combine` | `combine.mp3` | 조합 성공 | 등급업 느낌의 상승음 |
| 9 | `change` | `change.mp3` | 캐릭터 교체 | 교체/리롤 시 효과음 |
| 10 | `upgrade` | `upgrade.mp3` | 강화 성공 | 파워업 상승음 |

### 웨이브 (4종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 11 | `wave_start` | `wave_start.mp3` | 웨이브 시작 | 경고/알림 사이렌(너무 크면 안됨) |
| 12 | `boss_spawn` | `boss_spawn.mp3` | 보스 등장 | 묵직한 긴장감 |
| 13 | `wave_clear` | `wave_clear.mp3` | 웨이브 클리어 | 짧은 팡파레 |
| 14 | `base_hit` | `base_hit.mp3` | 기지 피격 | 위험 알림음 |

### UI (2종)
| # | 키 | 파일명 | 설명 | 참고 |
|---|---|---|---|---|
| 15 | `button_tap` | `button_tap.mp3` | 버튼 터치 | 가벼운 클릭음 |
| 16 | `game_over` | `game_over.mp3` | 게임오버 | 패배 연출음 |

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
        ├── change.mp3
        ├── upgrade.mp3
        ├── wave_start.mp3
        ├── boss_spawn.mp3
        ├── wave_clear.mp3
        ├── base_hit.mp3
        ├── button_tap.mp3
        └── game_over.mp3
```

## 파일 규격
- **포맷:** MP3 (용량 절감) 또는 OGG
- **샘플레이트:** 44100Hz
- **길이:** SFX는 0.3~2초 이내
- **볼륨:** 피크 -3dB 이하로 정규화

## 소스
- **Pixabay** (pixabay.com/sound-effects) — 상업용 무료, 출처 표기 불필요
- **Kenney** (kenney.nl) — 게임 특화 CC0 에셋
- **ElevenLabs Sound Effects** — AI 텍스트 기반 SFX 생성

## 향후 추가 예정
| 카테고리 | 항목 |
|---|---|
| 전투 SFX | 크리티컬 타격, 스턴 적용, AoE 폭발, 감속/버프/방깎 이펙트 |
| 연출 SFX | 전설 조합 특별 연출음 |
| BGM | 타이틀, 인게임, 보스전, 게임오버 |
