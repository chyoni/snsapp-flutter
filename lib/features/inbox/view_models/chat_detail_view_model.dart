import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/repositories/chat_repository.dart';

class ChatDetailViewModel extends FamilyAsyncNotifier<void, String> {
  late final String _chatRoomId;
  late final ChatRepository _chatRepository;

  @override
  FutureOr<void> build(String arg) {
    _chatRoomId = arg;
    _chatRepository = ref.read(chatRepo);
  }

  Future<void> sendMessage(String message) async {
    final user = ref.read(authRepo).user;
    if (user == null) throw Error();

    await _chatRepository.sendMessage(message, _chatRoomId, user.uid);
  }
}

final chatDetailProvider =
    AsyncNotifierProvider.family<ChatDetailViewModel, void, String>(
  () => ChatDetailViewModel(),
);
