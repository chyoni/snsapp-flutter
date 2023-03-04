import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok/common/view_models/common_config_vm.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/view_models/chat_detail_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";
  final String chatId;
  final String participantName;
  final String participantId;
  final String participantAvatar;
  const ChatDetailScreen({
    super.key,
    required this.chatId,
    required this.participantName,
    required this.participantId,
    required this.participantAvatar,
  });

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  Offset _tapPosition = Offset.zero;
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

  Future<void> _onSendingDmTap() async {
    final message = _textEditingController.text;
    if (message == "") return;
    await ref
        .read(chatDetailProvider(widget.chatId).notifier)
        .sendMessage(message);

    setState(() {
      isEnableSending = false;
      _textEditingController.text = "";
    });
  }

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  Future<void> _onMessageLongPressed(
    BuildContext context,
    String messageId,
  ) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
        Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
            overlay.paintBounds.size.height),
      ),
      items: [
        const PopupMenuItem(
          value: "Remove",
          child: Text("Remove"),
        )
      ],
    );

    if (result == "Remove") {
      await ref
          .read(chatDetailProvider(widget.chatId).notifier)
          .deleteMessage(messageId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSendingLoading =
        ref.watch(chatDetailProvider(widget.chatId)).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size6,
          leading: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              CircleAvatar(
                radius: Sizes.size24,
                backgroundImage: widget.participantAvatar == "true"
                    ? NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/chiwon99881tiktok.appspot.com/o/avatars%2F${widget.participantId}?alt=media")
                    : const AssetImage("assets/images/yerin2.jpg")
                        as ImageProvider,
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
                        color: ref.watch(commonConfigProvider).darkMode
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
            widget.participantName,
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
            child: ref.watch(chatStreamProvider(widget.chatId)).when(
                  error: (error, stackTrace) => Center(
                    child: Text("error occured -> $error"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  data: (messages) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size20,
                        horizontal: Sizes.size16,
                      ),
                      itemCount: messages.length,
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMine =
                            message.userId == ref.watch(authRepo).user!.uid;
                        return GestureDetector(
                          onTapDown: (details) => _getTapPosition(details),
                          onLongPress: isMine
                              ? () => _onMessageLongPressed(context, message.id)
                              : null,
                          child: Row(
                            mainAxisAlignment: isMine
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
                                    topLeft:
                                        const Radius.circular(Sizes.size20),
                                    topRight:
                                        const Radius.circular(Sizes.size20),
                                    bottomLeft: Radius.circular(
                                        isMine ? Sizes.size20 : 2),
                                    bottomRight: Radius.circular(
                                        !isMine ? Sizes.size20 : 2),
                                  ),
                                  color: isMine
                                      ? Colors.blue
                                      : Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  message.message,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              color: ref.watch(commonConfigProvider).darkMode
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
                          controller: _textEditingController,
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
                              fillColor:
                                  ref.watch(commonConfigProvider).darkMode
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
                                        color: ref
                                                .watch(commonConfigProvider)
                                                .darkMode
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
                      onTap: isEnableSending && !isSendingLoading
                          ? _onSendingDmTap
                          : null,
                      child: isSendingLoading
                          ? const CircularProgressIndicator.adaptive()
                          : Container(
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
