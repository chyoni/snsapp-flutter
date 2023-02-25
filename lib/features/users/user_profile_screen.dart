import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/settings/settings_screen.dart';
import 'package:tiktok/features/users/user_edit_screen.dart';
import 'package:tiktok/features/users/view_models/users_vm.dart';
import 'package:tiktok/features/users/widgets/avatar.dart';
import 'package:tiktok/features/users/widgets/persist_header_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;
  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  void _onEditPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UserEditScreen(),
      ),
    );
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
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        centerTitle: true,
                        title: Text(data.name),
                        actions: [
                          IconButton(
                            onPressed: _onEditPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.penToSquare,
                              size: Sizes.size20,
                            ),
                          ),
                          IconButton(
                            onPressed: _onGearPressed,
                            icon: const FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Avatar(
                              uid: data.uid,
                              name: data.name,
                              hasAvatar: data.hasAvatar,
                            ),
                            Gaps.v20,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "@${data.name}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Sizes.size16,
                                  ),
                                ),
                                Gaps.h8,
                                FaIcon(
                                  FontAwesomeIcons.solidCircleCheck,
                                  size: Sizes.size14,
                                  color: Colors.blue.shade200,
                                ),
                              ],
                            ),
                            Gaps.v24,
                            SizedBox(
                              height: Sizes.size48,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "86",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Following",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    // ! 위에 길이 자르는거
                                    indent: Sizes.size10,
                                    // ! 아래 길이 자르는거
                                    endIndent: Sizes.size10,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "10M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  VerticalDivider(
                                    width: Sizes.size32,
                                    thickness: Sizes.size1,
                                    color: Colors.grey.shade300,
                                    // ! 위에 길이 자르는거
                                    indent: Sizes.size10,
                                    // ! 아래 길이 자르는거
                                    endIndent: Sizes.size10,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        "193.3M",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: Sizes.size16,
                                        ),
                                      ),
                                      Gaps.v5,
                                      Text(
                                        "Likes",
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gaps.v14,
                            FractionallySizedBox(
                              widthFactor: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Sizes.size96 + Sizes.size48,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          Sizes.size4,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      "Follow",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Gaps.h5,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size10,
                                      horizontal: Sizes.size10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.youtube,
                                      size: Sizes.size24,
                                    ),
                                  ),
                                  Gaps.h5,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: Sizes.size10,
                                      horizontal: Sizes.size12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        Sizes.size4,
                                      ),
                                    ),
                                    child: const FaIcon(
                                      FontAwesomeIcons.arrowDown,
                                      size: Sizes.size24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Gaps.v14,
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Sizes.size20,
                              ),
                              child: Text(
                                "플러터 개꿀잼",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Gaps.v10,
                          ],
                        ),
                      ),
                      SliverPersistentHeader(
                        delegate: PersistHeaderTabBar(ref: ref),
                        pinned: true,
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      GridView.builder(
                        // ! GridView는 그 우리가 했던 unfocus를 사용하지 않고도 이런 옵션이 있다.
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: Sizes.size2,
                          mainAxisSpacing: Sizes.size1,
                          // ! 9 너비, 20 높이로 생각하면됨
                          childAspectRatio: 9 / 15,
                        ),
                        itemBuilder: (context, index) => Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Sizes.size4,
                                    ),
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 9 / 15,
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          "assets/images/placeholder.jpg",
                                      image:
                                          "https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
                                    ),
                                  ),
                                ),
                                if (index == 0)
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Sizes.size4,
                                          vertical: Sizes.size2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            Sizes.size4,
                                          ),
                                        ),
                                        child: const Text(
                                          "Pinned",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: Sizes.size12,
                                          ),
                                        )),
                                  ),
                                Positioned(
                                  bottom: 2,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.play_arrow_outlined,
                                        size: Sizes.size28,
                                        color: Colors.white,
                                      ),
                                      Gaps.h5,
                                      Text(
                                        "4.1M",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Center(
                        child: Text("Tab 2"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
