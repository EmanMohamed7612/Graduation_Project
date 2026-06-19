class ProductRecommendModel {
  final int id;
  final String name;
  final double price;
  final double rating;
  final String imageUrl;

  ProductRecommendModel({
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.imageUrl,
  });

  factory ProductRecommendModel.fromJson(Map<String, dynamic> json) {
    return ProductRecommendModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      // الـ API يرجعها باسم averageRating
      rating: (json['averageRating'] as num?)?.toDouble() ?? 0.0, 
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}