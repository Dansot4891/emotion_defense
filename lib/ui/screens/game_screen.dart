import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../core/const/style/app_color.dart';
import '../../core/emotion_defense_game.dart';
import '../overlays/action_bar.dart';
import '../overlays/character_info_popup.dart';
import '../overlays/combine_popup.dart';
import '../overlays/hud_overlay.dart';
import '../overlays/pause_popup.dart';
import '../overlays/reward_popup.dart';
import '../overlays/upgrade_popup.dart';
import 'game_over_screen.dart';

/// 게임 화면 - FlameGame GameWidget 래퍼 + 오버레이 등록
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late EmotionDefenseGame _game;

  @override
  void initState() {
    super.initState();
    _game = EmotionDefenseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'hud': (context, game) => HudOverlay(
                game: game as EmotionDefenseGame,
              ),
          'actionBar': (context, game) => ActionBar(
                game: game as EmotionDefenseGame,
              ),
          'gameOver': (context, game) => GameOverOverlay(
                game: game as EmotionDefenseGame,
              ),
          'combinePopup': (context, game) => CombinePopup(
                game: game as EmotionDefenseGame,
              ),
          'pausePopup': (context, game) => PausePopup(
                game: game as EmotionDefenseGame,
              ),
          'characterInfo': (context, game) => CharacterInfoPopup(
                game: game as EmotionDefenseGame,
              ),
          'rewardPopup': (context, game) => RewardPopup(
                game: game as EmotionDefenseGame,
              ),
          'upgradePopup': (context, game) => UpgradePopup(
                game: game as EmotionDefenseGame,
              ),
        },
        backgroundBuilder: (context) {
          return Container(color: AppColor.surface);
        },
      ),
    );
  }
}
