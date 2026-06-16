class CommentModel {
  final int id;
  final String text;
  final String userName;
  final String createdAt;
  final String timeAgo;

  CommentModel({
    required this.id,
    required this.text,
    required this.userName,
    required this.createdAt,
    required this.timeAgo,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      text: json['text'],
      userName: json['userName'],
      createdAt: json['createdAt'],
      timeAgo: json['timeAgo'],
    );
  }
}