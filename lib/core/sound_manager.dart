import 'package:flame_audio/flame_audio.dart';

/// SFX 키 상수 — 사운드 재생 시 이 키를 사용
abstract class Sfx {
  // 전투
  static const attack = 'attack';
  static const hit = 'hit';
  static const kill = 'kill';

  // 경제/시스템
  static const gold = 'gold';
  static const gacha = 'gacha';
  static const place = 'place';
  static const sell = 'sell';
  static const combine = 'combine';

  // 웨이브
  static const waveStart = 'wave_start';
  static const bossSpawn = 'boss_spawn';
  static const waveClear = 'wave_clear';
  static const baseHit = 'base_hit';

  // UI
  static const buttonTap = 'button_tap';
  static const gameOver = 'game_over';
  static const change = 'change';
  static const upgrade = 'upgrade';
}

/// 효과음(SFX) 관리자 — 싱글톤
class SoundManager {
  SoundManager._();
  static final SoundManager instance = SoundManager._();

  /// SFX 볼륨 (0.0 ~ 1.0)
  double sfxVolume = 1.0;

  /// SFX 음소거
  bool isMuted = false;

  /// 키 → 파일 경로 매핑 (assets/audio/ 하위)
  static const _sfxFiles = {
    Sfx.attack: 'sfx/attack.mp3',
    Sfx.hit: 'sfx/hit.mp3',
    Sfx.kill: 'sfx/kill.mp3',
    Sfx.gold: 'sfx/gold.mp3',
    Sfx.gacha: 'sfx/gacha.mp3',
    Sfx.place: 'sfx/place.mp3',
    Sfx.sell: 'sfx/sell.mp3',
    Sfx.combine: 'sfx/combine.mp3',
    Sfx.waveStart: 'sfx/wave_start.mp3',
    Sfx.bossSpawn: 'sfx/boss_spawn.mp3',
    Sfx.waveClear: 'sfx/wave_clear.mp3',
    Sfx.baseHit: 'sfx/base_hit.mp3',
    Sfx.buttonTap: 'sfx/button_tap.mp3',
    Sfx.gameOver: 'sfx/game_over.mp3',
    Sfx.change: 'sfx/change.mp3',
    Sfx.upgrade: 'sfx/upgrade.mp3',
  };

  /// SFX 프리로드 (실제 존재하는 파일만)
  Future<void> preload() async {
    for (final path in _sfxFiles.values) {
      try {
        await FlameAudio.audioCache.load(path);
      } catch (_) {
        // 파일 미존재 시 무시 (아직 추가 안 된 SFX)
      }
    }
  }

  /// SFX 재생
  void play(String key) {
    if (isMuted) return;
    final path = _sfxFiles[key];
    if (path == null) return;
    FlameAudio.play(path, volume: sfxVolume);
  }
}
