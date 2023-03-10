import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/authentication/sign_up_screen.dart';
import 'package:tiktok/features/inbox/views/activity_screen.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';
import 'package:tiktok/features/notifications/notifications_provider.dart';
import 'package:tiktok/features/onboarding/interests_screen.dart';
import 'package:tiktok/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider(
  (ref) {
    // ! auth 상태를 watch하는 statement (logout, login시 호출될거고 그에 따라 router도 rebuild)
    // ref.watch(authState);
    return GoRouter(
        initialLocation: "/home",
        redirect: (context, state) {
          final isLoggedIn = ref.read(authRepo).isLoggedIn;
          if (!isLoggedIn) {
            // ! state.subloc은 현재 Url이라고 생각하면 된다.
            if (state.subloc != SignUpScreen.routeURL &&
                state.subloc != LoginScreen.routeURL) {
              return SignUpScreen.routeURL;
            }
          }
          return null;
        },
        routes: [
          // ! ShellRoute는 routing할 때 어떤 특정 정보를 같이 만들어서 던져주는 그런 녀석,
          // ! child는 현재 라우팅된 화면을 의미, 예를 들어 SignupScreen으로 가면 child가 SignupScreen이고 LoginScreen으로 가면 child가 LoginScreen임
          // ! 이렇게 한 이유는 notificationsProvider가 context가 필요한데 기존에 우리가 main에서 notificationProvider를 watch할 땐 라우팅 정보 위에서 watch 했기 때문에
          // ! context가 routing정보를 못 가진채 notificationProvider에게 던져짐, 그래서 그거를 해결하고자 route 정보를 가지고 있는 채로 context를 주기 위함
          ShellRoute(
            builder: (context, state, child) {
              ref.read(notificationsProvider(context));
              return child;
            },
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
              // ! 이거 같은 경우는, /xxx 중에 xxx로 들어오는 Parameter는 허용가능한 녀석들이 routes는 /home, /discover, /inbox, /profile이라는 의미
              // ! 여기서 tab은 path가 아니고 parameter임, 즉 위에서 /login, /signup 같은 거는 바로 매치되는게 있는거고 여기서는 위에서 매치된 게 아닌 것 중 이 parameter중 가능한 4개를 의미하는거
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
                      final participantName =
                          state.queryParams["participantName"]!;
                      final participantId = state.queryParams["participantId"]!;
                      final participantAvatar =
                          state.queryParams["participantAvatar"]!;
                      return ChatDetailScreen(
                        chatId: chatId,
                        participantName: participantName,
                        participantId: participantId,
                        participantAvatar: participantAvatar,
                      );
                    },
                  )
                ],
              ),
              GoRoute(
                name: VideoRecordingScreen.routeName,
                path: VideoRecordingScreen.routePath,
                // ! pageBuilder를 이용해서 나만의 애니메이션을 만들 수 있다
                pageBuilder: (context, state) => CustomTransitionPage(
                  transitionDuration: const Duration(milliseconds: 300),
                  child: const VideoRecordingScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
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
          )
        ]);
  },
);
