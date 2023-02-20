import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/main.dart';

class PersistHeaderTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: TikTokApp.themeNotifier.value == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        border: Border.all(
            color: TikTokApp.themeNotifier.value == ThemeMode.dark
                ? Colors.black26
                : Colors.grey.shade300),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.all(Sizes.size12),
        labelColor: TikTokApp.themeNotifier.value == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        indicatorColor: TikTokApp.themeNotifier.value == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            child: Icon(
              FontAwesomeIcons.tableCells,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size12,
            ),
            child: Icon(
              FontAwesomeIcons.heart,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 53;

  @override
  double get minExtent => 53;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
