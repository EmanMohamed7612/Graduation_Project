class MessageModel {
  final int id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime sentAt;
  final bool isOwnMessage;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.sentAt,
    required this.isOwnMessage,
    required this.isRead,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      sentAt: DateTime.parse(json['sentAt']),
      isOwnMessage: json['isOwnMessage'] ?? false,
      isRead: json['isRead'] ?? false,
    );
  }
}