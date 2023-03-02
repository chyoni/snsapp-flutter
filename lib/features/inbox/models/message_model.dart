class MessageModel {
  final String message;
  final String userId;
  final int createdAt;

  MessageModel({
    required this.message,
    required this.userId,
    required this.createdAt,
  });

  MessageModel.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        userId = json["userId"],
        createdAt = json["createdAt"];
}
