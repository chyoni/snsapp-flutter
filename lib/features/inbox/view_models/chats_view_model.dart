import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/inbox/models/chat_list_item_model.dart';
import 'package:tiktok/features/inbox/repositories/chat_repository.dart';

class ChatsViewModel extends AsyncNotifier<List<ChatListItemModel>> {
  late final ChatRepository _chatRepository;
  List<ChatListItemModel> _list = [];

  @override
  FutureOr<List<ChatListItemModel>> build() async {
    _chatRepository = ref.read(chatRepo);
    List<ChatListItemModel> chatListItems = [];

    final allChatRooms = await _chatRepository.getAllChats();

    for (var room in allChatRooms.docs) {
      final participantId = room.id.split("000").last.trim();
      final participant = await _chatRepository.getUserById(participantId);
      if (participant.data() == null) throw Error();

      // TODO: get last message

      chatListItems.add(ChatListItemModel(
        chatRoomId: room.id,
        hasAvatar: participant.data()!["hasAvatar"],
        participantName: participant.data()!["name"],
        participantId: participant.id,
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
