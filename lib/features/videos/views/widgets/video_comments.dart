import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/generated/l10n.dart';

class VideoComments extends ConsumerStatefulWidget {
  const VideoComments({super.key});

  @override
  VideoCommentsState createState() => VideoCommentsState();
}

class VideoCommentsState extends ConsumerState<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _stopWriting,
      child: Container(
        height: size.height * 0.7,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size20),
        ),
        child: Scaffold(
          backgroundColor: ref.watch(commonConfigProvider).darkMode
              ? Colors.black
              : Colors.grey.shade50,
          appBar: AppBar(
            // ! backbutton 안 보이게
            automaticallyImplyLeading: false,
            title: Text(S.of(context).commentTitle(22154, 22154)),
            backgroundColor: ref.watch(commonConfigProvider).darkMode
                ? Colors.black
                : Colors.grey.shade50,
            actions: [
              IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark),
              ),
            ],
          ),
          body: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    top: Sizes.size10,
                    bottom: Sizes.size96 + Sizes.size20,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                            "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fimage.chosun.com%2Fsitedata%2Fimage%2F201912%2F11%2F2019121101152_0.png&f=1&nofb=1&ipt=9df9a3fcac217fdfe6a6b451562e12db8fe4600ab725e19fb7948a116e95be12&ipo=images"),
                        child: Text("백예린2"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "yerin_the_genuine",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                              "'New Year' 잘 듣고 계신가요? 지금 블루바이닐 네이버포스트에서 앨범의 비하인드도 만나보실 수 있습니다!",
                            ),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: ref.watch(commonConfigProvider).darkMode
                                ? Colors.grey.shade300
                                : Colors.grey.shade500,
                          ),
                          Gaps.v3,
                          Text(
                            "52.2K",
                            style: TextStyle(
                              color: ref.watch(commonConfigProvider).darkMode
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: ref.watch(commonConfigProvider).darkMode
                      ? Colors.grey.shade900
                      : Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size10,
                      bottom: Sizes.size10,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          foregroundImage: NetworkImage(
                              "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.nemopan.com%2Ffiles%2Fattach%2Fimages%2F6294%2F480%2F473%2F012%2Fe6fdf0be95a17f41126453c1a06b62fd.jpg&f=1&nofb=1&ipt=3787e4fb142c7940f5592b642d0eef37e5eb6113200a999ec88c507baaeed7a7&ipo=images"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              autocorrect: false,
                              onTap: _onStartWriting,
                              // ! 아래 4줄은 키보드에서 return을 누를 때 뉴라인으로 만들어주는 statement
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor:
                                    ref.watch(commonConfigProvider).darkMode
                                        ? Colors.grey.shade800
                                        : Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                  vertical: Sizes.size10,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: Sizes.size14),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: ref
                                                .watch(commonConfigProvider)
                                                .darkMode
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h8,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: ref
                                                .watch(commonConfigProvider)
                                                .darkMode
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h8,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: ref
                                                .watch(commonConfigProvider)
                                                .darkMode
                                            ? Colors.grey.shade300
                                            : Colors.grey.shade900,
                                        size: Sizes.size20,
                                      ),
                                      Gaps.h8,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowRight,
                                            size: Sizes.size20,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
