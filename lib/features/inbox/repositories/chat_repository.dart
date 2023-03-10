import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    final users = await _db.collection("users").get();
    return users;
  }

  Future<DocumentReference<Map<String, dynamic>>> createChatRoom(
      String meId, String participantId) async {
    final query = _db.collection("chat_rooms").doc("${meId}000$participantId");
    final chatRoom = await query.get();
    if (!chatRoom.exists) {
      await query.set({
        "createdAt": DateTime.now().millisecondsSinceEpoch,
      });
    }
    return query;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllChats() async {
    final chatRooms = await _db.collection("chat_rooms").get();
    return chatRooms;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserById(String uid) async {
    final user = await _db.collection("users").doc(uid).get();
    return user;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      String chatRoomId) async {
    final messages = await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("createdAt")
        .get();
    return messages;
  }

  Future<void> sendMessage(
      String message, String chatRoomId, String senderId) async {
    await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add({
      "userId": senderId,
      "message": message,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
    });
  }

  Future<void> deleteMessage(String messageId, String chatRoomId) async {
    await _db
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .doc(messageId)
        .delete();
  }
}

final chatRepo = Provider(
  (ref) => ChatRepository(),
);
