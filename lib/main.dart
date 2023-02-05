import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/main_navigation/main_navigation_screen.dart';

void main() async {
  // ! 얘는 runApp()을 호출하기전 설정해야할 무언가가 있을 때 runApp() 이전에 호출시키는 녀석
  WidgetsFlutterBinding.ensureInitialized();
  // ! 이거는 이제 디바이스가 세로로 놓여져 있을 때 보여지는 화면으로만 보여지게 하는 녀석,
  // ! 즉, 가로로 바꿔도 화면이 전환되지 않게끔 설정해줌
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TikTok',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          // ! 이거는 그 클릭할때 반짝하는 이펙트 없애는거
          splashColor: Colors.transparent,
          // ! 이거는 길게 누를때 반짝하는거 없애는거
          // highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const MainNavigationScreen() //SignUpScreen()
        );
  }
}
