import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../../../core/const/style/app_color.dart';
import '../../../core/emotion_defense_game.dart';
import '../../title/screen/title_screen.dart';
import '../widgets/app_bar/action_bar.dart';
import '../widgets/popup/character_info_popup.dart';
import '../widgets/popup/combine_popup.dart';
import '../widgets/overlay/hud_overlay.dart';
import '../widgets/popup/pause_popup.dart';
import '../widgets/popup/quest_popup.dart';
import '../widgets/popup/reward_popup.dart';
import '../widgets/popup/synergy_popup.dart';
import '../widgets/popup/upgrade_popup.dart';
import '../widgets/overlay/game_over_overlay.dart';

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
    _game = EmotionDefenseGame()
      ..selectedDifficulty = TitleScreen.selectedDifficulty;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final padding = MediaQuery.of(context).padding;
    _game.safeAreaTop = padding.top;
    _game.safeAreaBottom = padding.bottom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'hud': (context, game) =>
              HudOverlay(game: game as EmotionDefenseGame),
          'actionBar': (context, game) =>
              ActionBar(game: game as EmotionDefenseGame),
          'gameOver': (context, game) =>
              GameOverOverlay(game: game as EmotionDefenseGame),
          'combinePopup': (context, game) =>
              CombinePopup(game: game as EmotionDefenseGame),
          'pausePopup': (context, game) =>
              PausePopup(game: game as EmotionDefenseGame),
          'characterInfo': (context, game) =>
              CharacterInfoPopup(game: game as EmotionDefenseGame),
          'rewardPopup': (context, game) =>
              RewardPopup(game: game as EmotionDefenseGame),
          'upgradePopup': (context, game) =>
              UpgradePopup(game: game as EmotionDefenseGame),
          'questPopup': (context, game) =>
              QuestPopup(game: game as EmotionDefenseGame),
          'synergyPopup': (context, game) =>
              SynergyPopup(game: game as EmotionDefenseGame),
        },
        backgroundBuilder: (context) {
          return Container(color: AppColor.surface);
        },
      ),
    );
  }
}
