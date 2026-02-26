import 'package:emotion_defense/app/route/routes.dart';
import 'package:emotion_defense/presentation/shared/button/app_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/const/style/app_color.dart';
import '../../../../core/const/style/app_text_style.dart';
import '../../../../core/emotion_defense_game.dart';
import '../../../../core/sound_manager.dart';

/// 일시정지 오버레이 — 반투명 배경 + 사운드 설정 + 계속하기/타이틀 버튼
class PausePopup extends StatefulWidget {
  final EmotionDefenseGame game;

  const PausePopup({super.key, required this.game});

  @override
  State<PausePopup> createState() => _PausePopupState();
}

class _PausePopupState extends State<PausePopup> {
  final _sound = SoundManager.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 240,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColor.overlay,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.primary, width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '일시정지',
                style: AppTextStyle.gameOverTitle.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 24),

              // BGM 볼륨
              _VolumeRow(
                icon: Icons.music_note,
                label: 'BGM',
                isMuted: _sound.isBgmMuted,
                volume: _sound.bgmVolume,
                onMuteToggle: () => setState(() => _sound.toggleBgmMute()),
                onChanged: (v) => setState(() => _sound.setBgmVolume(v)),
              ),
              const SizedBox(height: 8),

              // SFX 볼륨
              _VolumeRow(
                icon: Icons.volume_up,
                label: 'SFX',
                isMuted: _sound.isSfxMuted,
                volume: _sound.sfxVolume,
                onMuteToggle: () => setState(() => _sound.toggleSfxMute()),
                onChanged: (v) => setState(() => _sound.sfxVolume = v),
              ),
              const SizedBox(height: 24),

              AppButton.basePrimary(
                text: '계속하기',
                textStyle: AppTextStyle.hudLabel,
                onTap: () => widget.game.togglePause(),
              ),
              const SizedBox(height: 12),
              AppButton.basePrimary(
                text: '타이틀로',
                bgColor: AppColor.danger,
                textStyle: AppTextStyle.hudLabel,
                onTap: () {
                  widget.game.togglePause();
                  TitleRoute().go(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 볼륨 조절 행 (음소거 토글 + 라벨 + 슬라이더)
class _VolumeRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isMuted;
  final double volume;
  final VoidCallback onMuteToggle;
  final ValueChanged<double> onChanged;

  const _VolumeRow({
    required this.icon,
    required this.label,
    required this.isMuted,
    required this.volume,
    required this.onMuteToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onMuteToggle,
          child: Icon(
            isMuted ? Icons.volume_off : icon,
            color: isMuted ? AppColor.textSecondary : AppColor.primary,
            size: 20,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyle.hudLabel.copyWith(
            fontSize: 10,
            color: isMuted ? AppColor.textSecondary : AppColor.textPrimary,
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColor.primary,
              inactiveTrackColor: AppColor.surface,
              thumbColor: AppColor.primary,
              overlayColor: AppColor.primary.withAlpha(30),
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: isMuted ? 0 : volume,
              onChanged: isMuted ? null : onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
