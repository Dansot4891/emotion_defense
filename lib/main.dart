import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/const/style/app_color.dart';
import 'ui/screens/title_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 세로 모드 고정
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const EmotionDefenseApp());
}

class EmotionDefenseApp extends StatelessWidget {
  const EmotionDefenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '감정디펜스',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColor.background,
      ),
      home: const TitleScreen(),
    );
  }
}
