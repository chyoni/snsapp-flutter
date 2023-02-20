import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/main.dart';

class ChatDetailScreen extends StatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";
  final String chatId;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  bool isEnableSending = false;

  void _onKeyboardDismiss() {
    FocusScope.of(context).unfocus();
  }

  void _onEditText(String value) {
    if (value.isNotEmpty) {
      setState(() {
        isEnableSending = true;
      });
    } else {
      setState(() {
        isEnableSending = false;
      });
    }
  }

  void _showEmojiTap() {}

  void _onSendingDmTap() {
    print("sending!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size6,
          leading: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                backgroundImage: AssetImage("assets/images/yerin2.jpg"),
              ),
              Positioned(
                bottom: 0,
                right: 3,
                child: Container(
                  width: Sizes.size14,
                  height: Sizes.size14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Sizes.size32,
                    ),
                    color: Colors.green.shade400,
                    boxShadow: [
                      BoxShadow(
                        color: TikTokApp.themeNotifier.value == ThemeMode.dark
                            ? Colors.grey.shade900
                            : Colors.white,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          title: Text(
            "yerin_the_genuine ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _onKeyboardDismiss,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size20,
                horizontal: Sizes.size16,
              ),
              itemCount: 10,
              separatorBuilder: (context, index) => Gaps.v10,
              itemBuilder: (context, index) {
                final fakeIsMine = index % 2 == 0;
                return Row(
                  mainAxisAlignment: fakeIsMine
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        Sizes.size12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(Sizes.size20),
                          topRight: const Radius.circular(Sizes.size20),
                          bottomLeft:
                              Radius.circular(fakeIsMine ? Sizes.size20 : 2),
                          bottomRight:
                              Radius.circular(!fakeIsMine ? Sizes.size20 : 2),
                        ),
                        color: fakeIsMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "Messages !",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: TikTokApp.themeNotifier.value == ThemeMode.dark
                  ? Colors.grey.shade900
                  : Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Sizes.size12,
                  left: Sizes.size20,
                  right: Sizes.size20,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size44,
                        child: TextField(
                          onChanged: (value) => _onEditText(value),
                          // ! 키보드에서 return이 newline이 되는 아래 4줄 (이를 사용하려면 TextField의 height를 정해줘야하는데 그를 위해 Sizedbox로 감싸주기)
                          expands: true,
                          minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                              hintText: "Send a message...",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size12),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size14,
                              ),
                              fillColor: TikTokApp.themeNotifier.value ==
                                      ThemeMode.dark
                                  ? Colors.grey.shade800
                                  : Colors.white,
                              suffixIcon: GestureDetector(
                                onTap: _showEmojiTap,
                                child: Container(
                                  width: 10,
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: Sizes.size10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.faceLaugh,
                                        size: Sizes.size20,
                                        color: TikTokApp.themeNotifier.value ==
                                                ThemeMode.dark
                                            ? Colors.grey.shade300
                                            : Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    GestureDetector(
                      onTap: isEnableSending ? _onSendingDmTap : null,
                      child: Container(
                        padding: const EdgeInsets.all(
                          Sizes.size10,
                        ),
                        decoration: BoxDecoration(
                          color: isEnableSending
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(
                            Sizes.size20,
                          ),
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.paperPlane,
                          size: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
