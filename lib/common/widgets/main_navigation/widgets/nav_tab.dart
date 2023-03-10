import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';

class NavTab extends ConsumerWidget {
  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    required this.selectedIcon,
    required this.isNotHome,
  });

  final String text;
  final bool isSelected;
  final bool isNotHome;
  final IconData icon;
  final IconData selectedIcon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(commonConfigProvider).darkMode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: isNotHome
              ? isDark
                  ? Colors.black
                  : Colors.white
              : Colors.black,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: isNotHome
                      ? isDark
                          ? Colors.white
                          : Colors.black
                      : Colors.white,
                ),
                Gaps.v5,
                Text(
                  text,
                  style: TextStyle(
                    color: isNotHome
                        ? isDark
                            ? Colors.white
                            : Colors.black
                        : Colors.white,
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
