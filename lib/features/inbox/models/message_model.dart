class MessageModel {
  final String id;
  final String message;
  final String userId;
  final int createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.userId,
    required this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json, messageId)
      : id = messageId,
        message = json["message"],
        userId = json["userId"],
        createdAt = json["createdAt"];
}
