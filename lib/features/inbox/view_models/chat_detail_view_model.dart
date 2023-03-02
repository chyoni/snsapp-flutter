import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok/features/inbox/models/message_model.dart';
import 'package:tiktok/features/inbox/repositories/chat_repository.dart';
import 'package:tiktok/features/inbox/view_models/chats_view_model.dart';

class ChatDetailViewModel extends FamilyAsyncNotifier<void, String> {
  late final String _chatRoomId;
  late final ChatRepository _chatRepository;

  @override
  FutureOr<void> build(String arg) {
    _chatRoomId = arg;
    _chatRepository = ref.read(chatRepo);
  }

  Future<void> sendMessage(String message) async {
    state = const AsyncValue.loading();
    final user = ref.read(authRepo).user;
    if (user == null) throw Error();
    state = await AsyncValue.guard(() async {
      await _chatRepository.sendMessage(message, _chatRoomId, user.uid);
      await ref.read(chatsProvider.notifier).refresh();
    });
  }

  Future<void> deleteMessage(String messageId) async {
    await _chatRepository.deleteMessage(messageId, _chatRoomId);
    await ref.read(chatsProvider.notifier).refresh();
  }
}

final chatDetailProvider =
    AsyncNotifierProvider.family<ChatDetailViewModel, void, String>(
  () => ChatDetailViewModel(),
);

final chatStreamProvider = StreamProvider.autoDispose
    .family<List<MessageModel>, String>((ref, chatRoomId) {
  final db = FirebaseFirestore.instance;
  return db
      .collection("chat_rooms")
      .doc(chatRoomId)
      .collection("messages")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map((doc) => MessageModel.fromJson(doc.data(), doc.id))
            .toList(),
      );
});
