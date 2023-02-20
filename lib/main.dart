import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/videos/repo/playback_config_repo.dart';
import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:tiktok/router.dart';

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

  // ! 핸드폰의 디스크에서 SharedPreferences instance를 가져옴
  final preferences = await SharedPreferences.getInstance();
  // ! 그 인스턴스를 PlaybackConfigRepository에 적용한 인스턴스를 생성
  final repository = PlaybackConfigRepository(preferences);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PlaybackConfigViewModel(repository),
        ),
      ],
      child: const TikTokApp(),
    ),
  );
}

class TikTokApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp.router(
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          title: 'TikTok',
          // ! AppLocalizations 이 녀석은 flutter gen-l10n 실행 시 만들어지는 파일안에 있는 클래스
          localizationsDelegates: const [
            S.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale("en"),
            Locale("ko"),
          ],
          themeMode: currentMode,
          darkTheme: ThemeData(
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            // ! Text Input 같은 필드에 focus할 때
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFE9435A),
            ),
            primaryColor: const Color(0xFFE9435A),
            textTheme: GoogleFonts.mavenProTextTheme(
              ThemeData(brightness: Brightness.dark).textTheme,
            ),
            bottomAppBarTheme: BottomAppBarTheme(
              color: Colors.grey.shade900,
            ),
            tabBarTheme: TabBarTheme(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey.shade500,
            ),
          ),
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color(0xFFE9435A),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Color(0xFFE9435A),
            ),
            // ! 이거는 그 클릭할때 반짝하는 이펙트 없애는거
            splashColor: Colors.transparent,
            // ! 이거는 길게 누를때 반짝하는거 없애는거
            textTheme: GoogleFonts.mavenProTextTheme(),
            // highlightColor: Colors.transparent,
            appBarTheme: AppBarTheme(
              surfaceTintColor: Colors.grey.shade50,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              titleTextStyle: const TextStyle(
                color: Colors.black,
                fontSize: Sizes.size16 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            tabBarTheme: TabBarTheme(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey.shade500,
            ),
          ),
        );
      },
    );
  }
}
