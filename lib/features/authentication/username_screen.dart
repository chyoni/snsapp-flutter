import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/email_screen.dart';
import 'package:tiktok/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok/features/authentication/widgets/form_button.dart';

class UsernameScreen extends ConsumerStatefulWidget {
  const UsernameScreen({super.key});

  @override
  UsernameScreenState createState() => UsernameScreenState();
}

class UsernameScreenState extends ConsumerState<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  @override
  void initState() {
    // ! initState는 super를 처음에 부르자.
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    // ! dispose는 super를 마지막에 부르자.
    _usernameController.dispose();
    super.dispose();
  }

  // ! StatefulWidget에서는 context를 안 던져줘도 알아서 context를 사용할 수 있다.
  void onNextTap() {
    if (_username.isEmpty) return;
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {...state, "username": _username};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(
          username: _username,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v12,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            GestureDetector(
              onTap: onNextTap,
              child: FormButton(disabled: _username.isEmpty),
            ),
          ],
        ),
      ),
    );
  }
}
