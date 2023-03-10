import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/breakpoints.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends ConsumerStatefulWidget {
  const DiscoverScreen({super.key});

  @override
  DiscoverScreenState createState() => DiscoverScreenState();
}

class DiscoverScreenState extends ConsumerState<DiscoverScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging ||
          _tabController.index != _tabController.previousIndex) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  void _onSearchChanged(String value) {
    if (_textEditingController.value.text.isNotEmpty) {
      setState(() {
        _showClearButton = true;
      });
    } else {
      setState(() {
        _showClearButton = false;
      });
    }
  }

  void _clearSearchTextTap() {
    setState(() {
      _textEditingController.text = "";
      _showClearButton = false;
    });
  }

  void _onSearchSubmitted(String value) {
    // ignore: avoid_print
    print("Submitted $value");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          title: Container(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: TextField(
              controller: _textEditingController,
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Search",
                iconColor: ref.watch(commonConfigProvider).darkMode
                    ? Colors.white
                    : Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.size12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size14,
                ),
                fillColor: ref.watch(commonConfigProvider).darkMode
                    ? Colors.grey.shade900
                    : Colors.grey.shade200,
                prefixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: Sizes.size14,
                      color: Colors.grey,
                    ),
                  ],
                ),
                suffixIcon: _showClearButton
                    ? GestureDetector(
                        onTap: _clearSearchTextTap,
                        child: Container(
                          width: 10,
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: Sizes.size10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              FaIcon(
                                FontAwesomeIcons.solidCircleXmark,
                                size: Sizes.size16,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      )
                    : null,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            labelPadding: const EdgeInsets.symmetric(
              vertical: Sizes.size16,
              horizontal: Sizes.size16,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: ref.watch(commonConfigProvider).darkMode
                ? Colors.white
                : Colors.black,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in tabs) Text(tab),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              // ! GridView??? ??? ????????? ?????? unfocus??? ???????????? ????????? ?????? ????????? ??????.
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size10,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 6 : 2,
                crossAxisSpacing: Sizes.size8,
                mainAxisSpacing: Sizes.size8,
                // ! 9 ??????, 20 ????????? ???????????????
                childAspectRatio: 9 / 20,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes.size4,
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.jpg",
                          image:
                              "https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=715&q=80",
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      "This is a very long caption This is a very long caption This is a very long caption This is a very long caption",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gaps.v6,
                    if (constraints.maxWidth > 195)
                      DefaultTextStyle(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ref.watch(commonConfigProvider).darkMode
                              ? Colors.grey.shade300
                              : Colors.grey.shade600,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage("assets/images/yerin.jpg"),
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                "yerin_the_genuine",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color:
                                        ref.watch(commonConfigProvider).darkMode
                                            ? Colors.white
                                            : Colors.grey.shade500),
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size14,
                              color: ref.watch(commonConfigProvider).darkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade600,
                            ),
                            Gaps.h2,
                            Text(
                              "2.5M",
                              style: TextStyle(
                                  color:
                                      ref.watch(commonConfigProvider).darkMode
                                          ? Colors.white
                                          : Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(tab),
              ),
          ],
        ),
      ),
    );
  }
}
