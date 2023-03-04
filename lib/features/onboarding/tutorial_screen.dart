import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

enum Direction { right, left }

enum Page { first, seconds }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction direction = Direction.right;
  Page showingPage = Page.first;

  // ! 사용자가 손가락으로 페이지를 움직이려고 드래그할 때 호출
  void onPanUpdate(DragUpdateDetails details) {
    // ! dx가 0보다 크다면 오른쪽으로 드래그중임을 의미
    if (details.delta.dx > 0) {
      setState(() {
        direction = Direction.right;
      });
    } else {
      // ! dx가 0보다 작다면 왼쪽으로 드래그중임을 의미
      setState(() {
        direction = Direction.left;
      });
    }
  }

  // ! 사용자가 손가락으로 드래그를 다 하고 손가락을 떼었을 때 호출
  void onPanEnd(DragEndDetails details) {
    if (direction == Direction.left) {
      setState(() {
        showingPage = Page.seconds;
      });
    } else {
      setState(() {
        showingPage = Page.first;
      });
    }
  }

  void onEnterAppTap() {
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const MainNavigationScreen(),
    //   ),
    //   (route) => false,
    // );
    // ! go / push 차이점은 go는 스택위에 쌓는게 아니고 아예 다른 화면으로 전환하는거라 이전 페이지가 없다. 즉 pop을 해도 전 화면으로 갈 수 없다란뜻
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: onPanUpdate,
      onPanEnd: onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              firstChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v60,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Gaps.v60,
                  Text(
                    "Follow the rules",
                    style: TextStyle(
                      fontSize: Sizes.size40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v16,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size20,
                    ),
                  ),
                ],
              ),
              crossFadeState: showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size24,
            horizontal: Sizes.size24,
          ),
          child: AnimatedOpacity(
            opacity: showingPage == Page.seconds ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: CupertinoButton(
              color: Theme.of(context).primaryColor,
              onPressed: onEnterAppTap,
              child: const Text(
                "Enter the app!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
