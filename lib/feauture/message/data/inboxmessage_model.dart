class InboxItemModel {
  final String otherUserId;
  final String otherUserName;
  final String otherAvatar;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isLastMessageMine;
  final int unreadCount;

  InboxItemModel({
    required this.otherUserId,
    required this.otherUserName,
    required this.otherAvatar,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isLastMessageMine,
    required this.unreadCount,
  });

  factory InboxItemModel.fromJson(Map<String, dynamic> json) {
    return InboxItemModel(
      // تأكدي من كتابة المفاتيح بالضبط كما في الـ Document صفحة 7
      otherUserId: json['otherUserld'] ?? "", // الـ Doc كاتبها بالـ L (ld)
      otherUserName: json['otherUserName'] ?? "Unknown",
      otherAvatar: json['otherAvatar'] ?? "",
      lastMessage: json['lastMessage'] ?? "",
      lastMessageTime: DateTime.parse(json['lastMessageTime'] ?? DateTime.now().toString()),
      isLastMessageMine: json['isLastMessageMine'] ?? false,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }
}