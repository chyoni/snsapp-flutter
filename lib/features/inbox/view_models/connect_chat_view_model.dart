import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/models/user_list_litem_model.dart';
import 'package:tiktok/features/inbox/repositories/chat_repository.dart';

class ConnectChatViewModel extends AsyncNotifier<List<UserListItemModel>> {
  late final ChatRepository _chatRepository;
  List<UserListItemModel> _list = [];

  @override
  FutureOr<List<UserListItemModel>> build() async {
    _chatRepository = ref.read(chatRepo);
    final results = await _chatRepository.getAllUsers();
    final users = results.docs
        .map((doc) => UserListItemModel.fromJson(doc.data()))
        .toList();
    _list = users;
    return _list;
  }

  Future<String?> createChatRoom(String participantId) async {
    final me = ref.read(authRepo).user;
    if (me == null) return null;
    final doc = await _chatRepository.createChatRoom(me.uid, participantId);
    return doc.id;
  }
}

final connectChatProvider =
    AsyncNotifierProvider<ConnectChatViewModel, List<UserListItemModel>>(
  () => ConnectChatViewModel(),
);
