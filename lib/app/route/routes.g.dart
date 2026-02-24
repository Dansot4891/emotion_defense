// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $titleRoute,
  $gameScreenRoute,
  $characterDetailRoute,
];

RouteBase get $titleRoute =>
    GoRouteData.$route(path: '/title', factory: $TitleRoute._fromState);

mixin $TitleRoute on GoRouteData {
  static TitleRoute _fromState(GoRouterState state) => const TitleRoute();

  @override
  String get location => GoRouteData.$location('/title');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $gameScreenRoute =>
    GoRouteData.$route(path: '/game', factory: $GameScreenRoute._fromState);

mixin $GameScreenRoute on GoRouteData {
  static GameScreenRoute _fromState(GoRouterState state) =>
      const GameScreenRoute();

  @override
  String get location => GoRouteData.$location('/game');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $characterDetailRoute => GoRouteData.$route(
  path: '/character-detail',
  factory: $CharacterDetailRoute._fromState,
);

mixin $CharacterDetailRoute on GoRouteData {
  static CharacterDetailRoute _fromState(GoRouterState state) =>
      const CharacterDetailRoute();

  @override
  String get location => GoRouteData.$location('/character-detail');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
