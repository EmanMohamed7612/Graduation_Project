// class ProductReviewModel {
//   final String ? reviewerName;
//   final int  ?rating;
//   final String ? review;
//   final dynamic createdAt;
//   final String? reviewerImage;
//   ProductReviewModel({
//     required this.reviewerName,
//     required this.rating,
//     required this.review,
//     required this.createdAt,
//     required this.reviewerImage,
//   });

//   // factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
//   //   return ProductReviewModel(
//   //     reviewerName: json['reviewerName'] ?? '',
//   //     createdAt: json['createdAt'] ?? '',
//   //     rating: json['rating'] ?? 0,
//   //     review: json['reviewComment'] ?? '',
//   //   );
//   // }

//   factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
//     return ProductReviewModel(
//       //interactionId: json['interactionId'] ?? json['InteractionId'],
//       //  reviewerId: json['reviewerId'] ?? json['ReviewerId'],
//       reviewerName: json['reviewerName'] ?? json['ReviewerName'] ?? '',
//       rating: json['rating'] ?? json['Rating'] ?? 0,
//       review: json['reviewComment'] ?? json['ReviewComment'] ?? '',
//       createdAt: json['createdAt'] ?? json['CreatedAt'] ?? '',
//       reviewerImage: json['reviewerImage'] ?? json['ReviewerImage'],
//     );
//   }
// }
class ProductReviewModel {
  final String reviewerName; // خليناها String لأننا ضامنين قيمة بديلة
  final double rating; // عدلناها لـ double عشان تقبل 4.5 أو 5.0
  final String review;
  final String createdAt;
  final String? reviewerImage;
  final String? itemImage;
  final String? categoryName;
  ProductReviewModel({
    required this.reviewerName,
    required this.rating,
    required this.review,
    required this.createdAt,
    this.reviewerImage, // ده الوحيد اللي ممكن يفضل Null عادي
    this.itemImage,
    this.categoryName, // ده الوحيد اللي ممكن يفضل Null عادي
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewModel(
      // استخدمنا ?.toString() عشان نتفادى أي Null Exception
      reviewerName:
          json['reviewerName']?.toString() ??
          json['ReviewerName']?.toString() ??
          'مستخدم غير معروف',

      // بنحول الـ rating لـ double عشان نتفادى مشكلة الكسور
      rating: (json['rating'] ?? json['Rating'] ?? 0).toDouble(),

      review:
          json['reviewComment']?.toString() ??
          json['ReviewComment']?.toString() ??
          '',
      categoryName:
          json['categoryName']?.toString() ??
          json['CategoryName']?.toString() ??
          '',
      createdAt:
          json['createdAt']?.toString() ?? json['CreatedAt']?.toString() ?? '',

      reviewerImage:
          json['reviewerImage']?.toString() ??
          json['ReviewerImage']?.toString(),
      itemImage: json['itemImage']?.toString() ?? json['ItemImage']?.toString(),
    );
  }
}
