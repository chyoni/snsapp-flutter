import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                onTap: () => onTap(0),
              ),
              NavTab(
                text: "Discover",
                isSelected: selectedIndex == 1,
                icon: FontAwesomeIcons.magnifyingGlass,
                onTap: () => onTap(1),
              ),
              NavTab(
                text: "Inbox",
                isSelected: selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                onTap: () => onTap(3),
              ),
              NavTab(
                text: "Profile",
                isSelected: selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                onTap: () => onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
