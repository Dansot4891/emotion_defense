import 'package:emotion_defense/app/route/routes.dart';
import 'package:go_router/go_router.dart';

/// 라우터 설정 클래스
class AppRouter {
  static GoRouter appRouter() {
    return GoRouter(
      initialLocation: const TitleRoute().location,
      routes: $appRoutes,
    );
  }
}
