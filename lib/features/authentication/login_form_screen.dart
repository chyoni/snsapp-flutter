import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/view_models/login_view_model.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({super.key});

  @override
  LoginFormScreenState createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map<String, String> loginData = {};

  void onSavedEmail(String? value) {
    if (value != null) {
      loginData['email'] = value;
    }
  }

  void onSavedPassword(String? value) {
    if (value != null) {
      loginData['password'] = value;
    }
  }

  void onSubmitLoginTap() {
    if (formKey.currentState != null) {
      if (formKey.currentState!.validate()) {
        formKey.currentState?.save();

        ref.read(loginProvider.notifier).logIn(
              loginData["email"]!,
              loginData["password"]!,
              context,
            );
        // ! pushAndRemoveUntil은 새로운 페이지로 라우팅을 하는데 그 전 페이지들로 다시 돌아갈 수 있냐마냐를 결정할 수 있다.
        // ! 그게 세번째 인자인 Function(route)인데 얘가 false를 리턴하면 그 전 페이지로 돌아갈 수 없게 네비게이팅한다.
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const InterestsScreen(),
        //   ),
        //   (route) {
        //     return false;
        //   },
        // );
        //context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Log in"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gaps.v28,
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      }
                      return null;
                    },
                    onSaved: onSavedEmail),
                Gaps.v16,
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    }
                    return null;
                  },
                  onSaved: onSavedPassword,
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: onSubmitLoginTap,
                  child: FormButton(
                    disabled: ref.watch(loginProvider).isLoading,
                    text: "Log in",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
