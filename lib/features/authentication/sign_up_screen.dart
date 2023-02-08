import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/login_screen.dart';
import 'package:tiktok/features/authentication/username_screen.dart';
import 'package:tiktok/features/authentication/widgets/auth_button.dart';
import 'package:tiktok/generated/l10n.dart';
import 'package:tiktok/utils.dart';

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
    // ! 이거는 l10n 파일 있으면 어떤 파일로 로드할지 그냥 픽스해버리는거
    S.load(const Locale("en"));
    if (kDebugMode) {
      print(Localizations.localeOf(context));
    }
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signUpTitle("TikTok"),
                    style: const TextStyle(
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
            color: isDarkMode(context) ? Colors.black38 : Colors.grey.shade50,
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
                      S.of(context).loginLinkString("other"),
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
