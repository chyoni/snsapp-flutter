import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/sizes.dart';

class PersistHeaderTabBar extends SliverPersistentHeaderDelegate {
  final WidgetRef ref;
  PersistHeaderTabBar({required this.ref});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: ref.watch(commonConfigProvider).darkMode
            ? Colors.black
            : Colors.white,
        border: Border.all(
            color: ref.watch(commonConfigProvider).darkMode
                ? Colors.black26
                : Colors.grey.shade300),
      ),
      child: TabBar(
        labelPadding: const EdgeInsets.all(Sizes.size12),
        labelColor: ref.watch(commonConfigProvider).darkMode
            ? Colors.white
            : Colors.black,
        indicatorColor: ref.watch(commonConfigProvider).darkMode
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
