// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $titleRoute,
  $gameScreenRoute,
  $characterBookScreenRoute,
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

RouteBase get $characterBookScreenRoute => GoRouteData.$route(
  path: '/character-book',
  factory: $CharacterBookScreenRoute._fromState,
);

mixin $CharacterBookScreenRoute on GoRouteData {
  static CharacterBookScreenRoute _fromState(GoRouterState state) =>
      const CharacterBookScreenRoute();

  @override
  String get location => GoRouteData.$location('/character-book');

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
