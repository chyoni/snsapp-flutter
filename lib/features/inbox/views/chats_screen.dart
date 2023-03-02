import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/models/chat_list_item_model.dart';
import 'package:tiktok/features/inbox/view_models/chats_view_model.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/views/connect_chat_screen.dart';
import 'package:tiktok/utils.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routePath = "/chats";
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  // final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  // final Duration _duration = const Duration(milliseconds: 300);

  void _newChatRoom() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConnectChatScreen(),
      ),
    );
  }

  // void _deleteItem(int index) {
  //   if (_key.currentState != null) {
  //     _key.currentState!.removeItem(
  //         index,
  //         (context, animation) => SizeTransition(
  //               sizeFactor: animation,
  //               child: _makeTile(index),
  //             ),
  //         duration: _duration);
  //   }
  // }

  void _onChatTap(ChatListItemModel chatRoom) {
    context.pushNamed(ChatDetailScreen.routeName, params: {
      "chatId": chatRoom.chatRoomId,
    }, queryParams: {
      "participantName": chatRoom.participantName,
      "participantId": chatRoom.participantId,
      "participantAvatar": chatRoom.hasAvatar.toString(),
    });
  }

  Widget _makeTile(ChatListItemModel chatRoom) {
    return ListTile(
      onLongPress: () {},
      onTap: () => _onChatTap(chatRoom),
      key: UniqueKey(),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: chatRoom.hasAvatar
            ? NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/chiwon99881tiktok.appspot.com/o/avatars%2F${chatRoom.participantId}?alt=media",
              )
            : const AssetImage("assets/images/yerin2.jpg") as ImageProvider,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chatRoom.participantName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            chatRoom.lastMessageTime != null
                ? convertTimestampToDateTime(chatRoom.lastMessageTime!)
                    .toString()
                    .split(".")[0]
                : "",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: Text(chatRoom.lastMessage != null ? chatRoom.lastMessage! : ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(chatsProvider).when(
          error: (error, stackTrace) => Center(
            child: Text("error occured -> $error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (chatRooms) {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                title: const Text("Direct messages"),
                actions: [
                  IconButton(
                    onPressed: _newChatRoom,
                    icon: const FaIcon(
                      FontAwesomeIcons.plus,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              body: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size16,
                ),
                separatorBuilder: (context, index) => Gaps.v16,
                itemCount: chatRooms.length,
                itemBuilder: (context, index) {
                  final chatRoom = chatRooms[index];
                  return _makeTile(chatRoom);
                },
              ),
              // ! AnimatedList
              // body: AnimatedList(
              //   key: _key,
              //   padding: const EdgeInsets.symmetric(
              //     vertical: Sizes.size10,
              //   ),
              //   initialItemCount: chatRooms.length,
              //   itemBuilder: (BuildContext context, int index,
              //       Animation<double> animation) {
              //     final chatRoom = chatRooms[index];
              //     // ! FadeTransition은 그 opacity가 애니메이티드 되는거
              //     return FadeTransition(
              //       key: UniqueKey(),
              //       opacity: animation,
              //       // ! SizeTransition은 아이템이 새로 추가될 때 위에서 아래로 스윽 하고 내려오는듯하게
              //       child: SizeTransition(
              //           sizeFactor: animation, child: _makeTile(chatRoom)),
              //     );
              //   },
              // ),
            );
          },
        );
  }
}
