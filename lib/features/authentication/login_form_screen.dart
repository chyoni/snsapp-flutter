import 'package:flutter/material.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
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
                    return null;
                  },
                  onSaved: onSavedPassword,
                ),
                Gaps.v28,
                GestureDetector(
                  onTap: onSubmitLoginTap,
                  child: const FormButton(
                    disabled: false,
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
