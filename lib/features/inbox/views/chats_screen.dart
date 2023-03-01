import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/inbox/view_models/chats_view_model.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok/features/inbox/views/connect_chat_screen.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routePath = "/chats";
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final Duration _duration = const Duration(milliseconds: 300);

  void _newChatRoom() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ConnectChatScreen(),
      ),
    );
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
          index,
          (context, animation) => SizeTransition(
                sizeFactor: animation,
                child: _makeTile(index),
              ),
          duration: _duration);
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: () => _onChatTap(index),
      key: UniqueKey(),
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage("assets/images/yerin2.jpg"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "yerin_the_genuine",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: const Text("치워낭!"),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.read(chatsProvider.notifier).build;
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
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          // ! FadeTransition은 그 opacity가 애니메이티드 되는거
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            // ! SizeTransition은 아이템이 새로 추가될 때 위에서 아래로 스윽 하고 내려오는듯하게
            child:
                SizeTransition(sizeFactor: animation, child: _makeTile(index)),
          );
        },
      ),
    );
  }
}
