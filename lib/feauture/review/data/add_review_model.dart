class AddReviewRequest {
  final int? productId;
  final int rating;
  final String? review;
  final int? rawMaterialId;
  final String? targetUserId;
  AddReviewRequest({this.productId, required this.rating, this.review, this.rawMaterialId, this.targetUserId});

  Map<String, dynamic> toJson() {
    return {
      if (productId != null) 'productId': productId,
      'rating': rating,
      if (review != null && review!.isNotEmpty) 'review': review,
      if (rawMaterialId != null) 'rawMaterialId': rawMaterialId,
      if (targetUserId != null) 'targetUserId': targetUserId,
    };
  }
}
