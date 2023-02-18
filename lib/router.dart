import 'package:go_router/go_router.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecordingScreen(),
    ),
    // GoRoute(
    //   path: SignUpScreen.routeName,
    //   builder: (context, state) => const SignUpScreen(),
    // ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => const LoginScreen(),
    // ),
    // GoRoute(
    //   path: BirthdayScreen.routeName,
    //   builder: (context, state) => const BirthdayScreen(),
    // ),
    // GoRoute(
    //   path: InterestsScreen.routeName,
    //   builder: (context, state) => const InterestsScreen(),
    // ),
    // GoRoute(
    //   path: MainNavigationScreen.routeName,
    //   builder: (context, state) => const MainNavigationScreen(),
    // ),
    // GoRoute(
    //   path: UsernameScreen.routeName,
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: child,
    //         );
    //       },
    //     );
    //   },
    // ),
    // GoRoute(
    //   path: EmailScreen.routeName,
    //   builder: (context, state) {
    //     final args = state.extra as EmailScreenArgs;
    //     return EmailScreen(username: args.username);
    //   },
    // ),
    // GoRoute(
    //   path: "/users/:username",
    //   builder: (context, state) {
    //     final username = state.params['username'];
    //     final tab = state.queryParams['tab'];
    //     return UserProfileScreen(username: username!, tab: tab!);
    //   },
    // ),
  ],
);
