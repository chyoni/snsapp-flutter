import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok/constants/gaps.dart';
import 'package:tiktok/constants/sizes.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/models/user_list_litem_model.dart';
import 'package:tiktok/features/inbox/view_models/connect_chat_view_model.dart';
import 'package:tiktok/features/inbox/views/chat_detail_screen.dart';

class ConnectChatScreen extends ConsumerStatefulWidget {
  const ConnectChatScreen({super.key});

  @override
  ConnectChatScreenState createState() => ConnectChatScreenState();
}

class ConnectChatScreenState extends ConsumerState<ConnectChatScreen> {
  String? _currentUserId;
  String? _currentUserName;
  String? _currentUserAvatar;

  void _onUserTap(UserListItemModel user) {
    if (user.uid == _currentUserId) {
      _currentUserId = null;
      _currentUserName = null;
      _currentUserAvatar = null;
    } else {
      _currentUserId = user.uid;
      _currentUserName = user.name;
      _currentUserAvatar = user.hasAvatar.toString();
    }
    setState(() {});
  }

  void _createChatRoom() async {
    if (_currentUserId == null ||
        _currentUserName == null ||
        _currentUserAvatar == null) return;
    final chatRoomId = await ref
        .read(connectChatProvider.notifier)
        .createChatRoom(_currentUserId!);
    if (chatRoomId == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something wrong. please again later."),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
      context.pushNamed(ChatDetailScreen.routeName, params: {
        "chatId": chatRoomId
      }, queryParams: {
        "participantName": _currentUserName,
        "participantId": _currentUserId,
        "participantAvatar": _currentUserAvatar,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(connectChatProvider).when(
          error: (error, stackTrace) => Center(
            child: Text("error occured -> $error"),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (user) {
            final me = ref.read(authRepo).user;
            user = user.where((u) => u.uid != me!.uid).toList();
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("New Message"),
                actions: [
                  TextButton(
                    onPressed: _currentUserId == null ? null : _createChatRoom,
                    child: const Text(
                      "Chat",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) => Gaps.v10,
                itemCount: user.length,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size20,
                ),
                itemBuilder: (context, index) {
                  final userData = user[index];
                  return ListTile(
                    onTap: () => _onUserTap(userData),
                    horizontalTitleGap: Sizes.size10,
                    key: UniqueKey(),
                    leading: CircleAvatar(
                      radius: Sizes.size32,
                      foregroundImage: userData.hasAvatar
                          ? NetworkImage(
                              "https://firebasestorage.googleapis.com/v0/b/chiwon99881tiktok.appspot.com/o/avatars%2F${userData.uid}?alt=media")
                          : const AssetImage("assets/images/yerin2.jpg")
                              as ImageProvider,
                    ),
                    title: Text(
                      userData.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Sizes.size16,
                      ),
                    ),
                    trailing: _currentUserId == userData.uid
                        ? const Icon(
                            Icons.check_circle,
                            size: Sizes.size24,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            size: Sizes.size24,
                          ),
                  );
                },
              ),
            );
          },
        );
  }
}
