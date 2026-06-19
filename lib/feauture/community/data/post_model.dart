class PostModel {
  final int id;
  final String userId;
  final String content;
  final String? imageUrl;
  final String createdAt;
  final String userName;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final String? userImage;
  PostModel({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.userName,
    required this.likesCount,
    required this.commentsCount,
    required this.isLikedByMe,
    this.userImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'] ?? json['UserId'] ?? "",
      content: json['content'] ?? json['Content'] ?? "",
      imageUrl: json['imageUrl'] ?? json['ImageUrl'],
      createdAt: json['createdAt'] ?? json['CreatedAt'],
      userName: json['userName'] ?? json['UserName'] ?? "Unknown",
      likesCount: json['likesCount'] ?? json['LikesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? json['CommentsCount'] ?? 0,
      isLikedByMe: json['isLikedByMe'] ?? json['IsLikedByMe'] ?? false,
      userImage: json['userImage'] ?? json['UserImage'],
    );
  }

  PostModel copyWith({
    int? id,
    String? content,
    String? imageUrl,
    String? createdAt,
    String? userName,
    int? likesCount,
    int? commentsCount,
    bool? isLikedByMe,
    String? userImage,
    String? userId,
  }) {
    return PostModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      userName: userName ?? this.userName,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      userImage: userImage ?? this.userImage,
    );
  }
}
