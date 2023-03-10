import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/generated/l10n.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeName = "signUp";
  static const String routeURL = "/";
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);

    // ! push와 go의 차이점은 push는 stack에 맨 위로 화면을 쌓는거고 go는 그냥 바로 이동시킨다.
    // ! 그래서 push와 다르게 go를 사용하면 전 화면으로 돌아갈 수 없다.
    //context.go(LoginScreen.routeName);
  }

  void onUsernamePasswordTap(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 500),
    //     reverseTransitionDuration: const Duration(milliseconds: 500),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    //         FadeTransition(
    //       opacity: animation,
    //       child: child,
    //     ),
    //   ),
    // );
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ! 이거는 l10n 파일 있으면 어떤 파일로 로드할지 그냥 픽스해버리는거
    S.load(const Locale("en"));
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Sign up for TikTok",
                    // S.of(context).signUpTitle("TikTok"),
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    S.of(context).signUpSubTitle(3),
                    style: const TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gaps.v40,
                  // ! Collection if를 쓸 때 여러개를 렌더링하고 싶으면 아래와 같이 ...[]으로 트릭을 쓸 수 있다.
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                        onTap: onUsernamePasswordTap,
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: "Use email & password"),
                    Gaps.v16,
                    AuthButton(
                        onTap: (context) => ref
                            .read(socialAuthProvider.notifier)
                            .githubSignIn(context),
                        icon: const FaIcon(FontAwesomeIcons.github),
                        text: "Continue with Github"),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                              onTap: onUsernamePasswordTap,
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: "Use email & password"),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                              onTap: onUsernamePasswordTap,
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Apple"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: ref.watch(commonConfigProvider).darkMode
                ? Colors.black38
                : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                  ),
                  Gaps.h10,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      "Log in",
                      // S.of(context).loginLinkString("other"),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
