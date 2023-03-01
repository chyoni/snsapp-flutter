class ChatListItemModel {
  final String chatRoomId;
  final bool hasAvatar;
  final String participantName;
  final String participantId;
  final String? lastMessage;
  final int? lastMessageTime;

  ChatListItemModel({
    required this.chatRoomId,
    required this.hasAvatar,
    required this.participantName,
    required this.participantId,
    this.lastMessage,
    this.lastMessageTime,
  });

  ChatListItemModel.fromJson(Map<String, dynamic> json)
      : chatRoomId = json["chatRoomId"],
        hasAvatar = json["hasAvatar"],
        participantId = json["participantId"],
        participantName = json["participantName"],
        lastMessage = json["lastMessage"] ?? "",
        lastMessageTime = json["lastMessageTime"] ?? 0;
}
