import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/views/activity_screen.dart';
import 'package:tiktok/features/inbox/views/chats_screen.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(ChatScreen.routeName);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inbox"),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              "Activity",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: ref.watch(commonConfigProvider).darkMode
                  ? Colors.white
                  : Colors.black,
              size: Sizes.size14,
            ),
          ),
          Container(
            height: Sizes.size1,
            color: Colors.grey.shade200,
          ),
          ListTile(
            leading: Container(
              width: Sizes.size40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              "New followers",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              color: ref.watch(commonConfigProvider).darkMode
                  ? Colors.white
                  : Colors.black,
              size: Sizes.size14,
            ),
          ),
        ],
      ),
    );
  }
}
