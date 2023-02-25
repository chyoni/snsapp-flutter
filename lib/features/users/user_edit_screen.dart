import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';

class UserEditScreen extends ConsumerStatefulWidget {
  const UserEditScreen({super.key});

  @override
  UserEditScreenState createState() => UserEditScreenState();
}

class UserEditScreenState extends ConsumerState<UserEditScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setInitialTextField();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _setInitialTextField() {
    final state = ref.read(usersProvider).value;
    if (state == null) return;

    _usernameController.value = TextEditingValue(text: state.name);
    _bioController.value =
        TextEditingValue(text: state.bio == "undefined" ? "" : state.bio);
    _linkController.value =
        TextEditingValue(text: state.link == "undefined" ? "" : state.link);
  }

  void _onEditActionPressed() {
    final username = _usernameController.value.text;
    final bio = _bioController.value.text;
    final link = _linkController.value.text;

    ref
        .read(usersProvider.notifier)
        .updateProfile(username, bio, link, context);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            appBar: AppBar(
              title: const Text("Edit Profile"),
              actions: [
                ref.read(usersProvider).isLoading
                    ? const CircularProgressIndicator.adaptive()
                    : IconButton(
                        onPressed: ref.read(usersProvider).isLoading
                            ? null
                            : _onEditActionPressed,
                        icon: Icon(
                          FontAwesomeIcons.checkDouble,
                          color: Colors.blue.shade500,
                        ),
                      ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v20,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Username",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                          Gaps.h10,
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Bio",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                          Gaps.h10,
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _bioController,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 1,
                            child: Text(
                              "Link",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: Sizes.size16,
                              ),
                            ),
                          ),
                          Gaps.h10,
                          Expanded(
                            flex: 4,
                            child: TextField(
                              controller: _linkController,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade700,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
