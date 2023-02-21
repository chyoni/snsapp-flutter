import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/birthday_screen.dart';
import 'package:tiktok/features/authentication/view_models/signup_vm.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  PasswordScreenState createState() => PasswordScreenState();
}

class PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool isObscured = true;

  @override
  void initState() {
    // ! initState는 super를 처음에 부르자.
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    // ! dispose는 super를 마지막에 부르자.
    _passwordController.dispose();
    super.dispose();
  }

  bool isPasswordValid() {
    return _password.isNotEmpty &&
        _password.length > 8 &&
        _password.length < 20;
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void onSubmit() {
    if (!isPasswordValid()) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "password": _password};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void onClearTap() {
    _passwordController.clear();
  }

  void toggleObscureText() {
    isObscured = !isObscured;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                obscureText: isObscured,
                onEditingComplete: onSubmit,
                decoration: InputDecoration(
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: toggleObscureText,
                        child: FaIcon(
                          isObscured
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                "Your password must have:",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color:
                        isPasswordValid() ? Colors.green : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text("8 to 20 characters"),
                ],
              ),
              Gaps.v28,
              GestureDetector(
                onTap: onSubmit,
                child: FormButton(disabled: !isPasswordValid()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
