import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/sizes.dart';

class PostVideoButton extends ConsumerWidget {
  final bool isNotHome;

  const PostVideoButton({
    super.key,
    required this.isNotHome,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                ? ref.watch(commonConfigProvider).darkMode
                    ? Colors.white
                    : Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(Sizes.size8),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: isNotHome
                  ? ref.watch(commonConfigProvider).darkMode
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
