import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLiked;

  const VideoButton({
    super.key,
    required this.icon,
    required this.text,
    this.isLiked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: isLiked ? Theme.of(context).primaryColor : Colors.white,
          size: Sizes.size36,
        ),
        Gaps.v6,
        Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
