import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void onUsernamePasswordTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    "Sign up for Tiktok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Create a profile, follow other accounts, make your own videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
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
                        onTap: onUsernamePasswordTap,
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Apple"),
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
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade200,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  Gaps.h10,
                  GestureDetector(
                    onTap: () => onLoginTap(context),
                    child: Text(
                      "Log in",
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
