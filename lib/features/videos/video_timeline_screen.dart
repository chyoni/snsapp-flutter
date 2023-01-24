import 'package:flutter/material.dart';
import 'package:tiktok/constants/sizes.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;
  final PageController _pageController = PageController();

  final List<Color> _colors = [
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      setState(() {
        _itemCount = _itemCount + 4;
        _colors.addAll([
          Colors.blue,
          Colors.yellow,
          Colors.pink,
          Colors.teal,
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) {
        return Container(
          color: _colors[index],
          child: Center(
            child: Text(
              "Screen $index",
              style: const TextStyle(
                fontSize: Sizes.size28,
              ),
            ),
          ),
        );
      },
    );
  }
}
