import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../ui/screens/character_detail_screen.dart';
import '../../ui/screens/game_screen.dart';
import '../../ui/screens/title_screen.dart';

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

@TypedGoRoute<CharacterDetailRoute>(path: '/character-detail')
class CharacterDetailRoute extends GoRouteData with $CharacterDetailRoute {
  const CharacterDetailRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CharacterDetailScreen();
  }
}
