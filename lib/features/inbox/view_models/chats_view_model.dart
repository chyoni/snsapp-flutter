import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/models/chat_list_item_model.dart';
import 'package:tiktok/features/inbox/repositories/chat_repository.dart';

class ChatsViewModel extends AsyncNotifier<List<ChatListItemModel>> {
  late final ChatRepository _chatRepository;
  List<ChatListItemModel> _list = [];

  @override
  FutureOr<List<ChatListItemModel>> build() async {
    _chatRepository = ref.read(chatRepo);
    List<ChatListItemModel> chatListItems = [];
    Map<String, dynamic>? lastMessage;

    final allChatRooms = await _chatRepository.getAllChats();
    final meId = ref.read(authRepo).user!.uid;

    for (var room in allChatRooms.docs) {
      final userId = room.id.split("000").first.trim();
      if (meId != userId) continue;

      final participantId = room.id.split("000").last.trim();
      final participant = await _chatRepository.getUserById(participantId);
      if (participant.data() == null) throw Error();

      final allMessages = await _chatRepository.getAllMessages(room.id);

      if (allMessages.docs.isNotEmpty) {
        lastMessage = allMessages.docs.last.data();
      }

      chatListItems.add(ChatListItemModel(
        chatRoomId: room.id,
        hasAvatar: participant.data()!["hasAvatar"],
        participantName: participant.data()!["name"],
        participantId: participant.id,
        lastMessage: lastMessage != null ? lastMessage["message"] : null,
        lastMessageTime: lastMessage != null ? lastMessage["createdAt"] : null,
      ));
    }
    _list = chatListItems;
    return _list;
  }
}

final chatsProvider =
    AsyncNotifierProvider<ChatsViewModel, List<ChatListItemModel>>(
  () => ChatsViewModel(),
);
