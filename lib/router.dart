import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/inbox/activity_screen.dart';
import 'package:tiktok/features/inbox/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/chats_screen.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';
import 'package:tiktok/features/videos/video_recording_screen.dart';

final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    // ! 이거 같은 경우는, /xxx 중에 허용하는 routes는 /home, /discover, /inbox, /profile이라는 의미
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|discover|inbox|profile)",
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routePath,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: ChatScreen.routeName,
      path: ChatScreen.routePath,
      builder: (context, state) => const ChatScreen(),
      // ! 이렇게 만들면 /chat/1, /chat/2, ... 이렇게 child 형태로 routing할 수 있음
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeURL,
          builder: (context, state) {
            final chatId = state.params["chatId"]!;
            return ChatDetailScreen(chatId: chatId);
          },
        )
      ],
    ),
    GoRoute(
      name: VideoRecordingScreen.routeName,
      path: VideoRecordingScreen.routePath,
      pageBuilder: (context, state) => CustomTransitionPage(
        transitionDuration: const Duration(milliseconds: 300),
        child: const VideoRecordingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final position = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: position,
            child: child,
          );
        },
      ),
    ),
  ],
);
