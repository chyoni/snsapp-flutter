import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/features/authentication/repo/authentication_repo.dart';

import 'package:tiktok/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  // ! Riverpod을 사용하기 위해 ConsumerWidget으로 변경했고, 그렇게 변경하면 build method는 하나를 더 파라미터로 받는데 그게 WidgetRef다.
  // ! 이 WidgetRef를 통해 Provider로 던져준 ViewModel(Notifier)의 원하는 state, 원하는 method에 접근할 수 있다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              // ! playbackConfigProvider를 watch또는 read하면, 이 녀석이 Listen하고 있는 데이터에만 접근이 가능하다.
              value: ref.watch(commonConfigProvider).darkMode,
              onChanged: (value) =>
                  // ! playbackConfigProvider.notifier를 watch, read하면 얘가 가지고 있는 클래스의 method에 접근이 가능하다.
                  ref.read(commonConfigProvider.notifier).setDarkMode(value),
              title: const Text("Dark mode"),
              subtitle: const Text("Set dark mode"),
            ),
            SwitchListTile.adaptive(
              // ! playbackConfigProvider를 watch또는 read하면, 이 녀석이 Listen하고 있는 데이터에만 접근이 가능하다.
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  // ! playbackConfigProvider.notifier를 watch, read하면 얘가 가지고 있는 클래스의 method에 접근이 가능하다.
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text("Video mute"),
              subtitle: const Text("Set video mute or not"),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text("Video autoplay"),
              subtitle: const Text("Set video auto play"),
            ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) {},
              title: const Text("Enable notifications with switch"),
            ),
            CheckboxListTile(
              activeColor: Colors.black,
              value: false,
              onChanged: (value) {},
              title: const Text("Enable notifications"),
            ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                        appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black),
                      ),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => ref.read(authRepo).signOut(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (Android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.arrowsLeftRightToLine),
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.doorClosed),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (iOS / bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("NOoooooo!"),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        isDestructiveAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Log out"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(),
          ],
        ),
      ),
    );
  }
}
