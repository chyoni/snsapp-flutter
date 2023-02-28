import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoButton extends StatefulWidget {
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
  State<VideoButton> createState() => _VideoButtonState();
}

class _VideoButtonState extends State<VideoButton>
    with SingleTickerProviderStateMixin {
  late Animation<Color?> _colorAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _colorAnimation =
        ColorTween(begin: Colors.white, end: const Color(0xFFE9435A))
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: FaIcon(
            widget.icon,
            color:
                widget.isLiked ? Theme.of(context).primaryColor : Colors.white,
            size: Sizes.size36,
          ),
        ),
        Gaps.v6,
        Text(
          widget.text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
