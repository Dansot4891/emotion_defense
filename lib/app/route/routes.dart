import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/character_book/screen/character_book_screen.dart';
import '../../presentation/game/screen/game_screen.dart';
import '../../presentation/title/screen/title_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<TitleRoute>(path: '/title')
class TitleRoute extends GoRouteData with $TitleRoute {
  const TitleRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TitleScreen();
  }
}

@TypedGoRoute<GameScreenRoute>(path: '/game')
class GameScreenRoute extends GoRouteData with $GameScreenRoute {
  const GameScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GameScreen();
  }
}

@TypedGoRoute<CharacterBookScreenRoute>(path: '/character-book')
class CharacterBookScreenRoute extends GoRouteData
    with $CharacterBookScreenRoute {
  const CharacterBookScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CharacterBookScreen();
  }
}
