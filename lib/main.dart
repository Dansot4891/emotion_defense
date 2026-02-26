import 'package:easy_localization/easy_localization.dart';
import 'package:emotion_defense/app/localization/locale_keys.dart';
import 'package:emotion_defense/app/route/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/const/style/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // 세로 모드 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ko', 'KR')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ko', 'KR'),
      // startLocale: const Locale('ko', 'KR'),
      startLocale: const Locale('en', 'US'),
      child: const EmotionDefenseApp(),
    ),
  );
}

class EmotionDefenseApp extends StatelessWidget {
  const EmotionDefenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: LocaleKeys.appName.tr(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColor.background,
      ),
      routerConfig: AppRouter.appRouter(),
    );
  }
}
