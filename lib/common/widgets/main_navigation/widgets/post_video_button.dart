import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/main.dart';

class PostVideoButton extends StatelessWidget {
  final bool isNotHome;

  const PostVideoButton({
    super.key,
    required this.isNotHome,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 20,
          child: Container(
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(Sizes.size11),
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: Container(
            height: 30,
            width: 25,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(Sizes.size11),
            ),
          ),
        ),
        Container(
          height: 30,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size11,
          ),
          decoration: BoxDecoration(
            color: isNotHome
                ? TikTokApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.white
                    : Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: isNotHome
                  ? TikTokApp.themeNotifier.value == ThemeMode.dark
                      ? Colors.black
                      : Colors.white
                  : Colors.black,
              size: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}
