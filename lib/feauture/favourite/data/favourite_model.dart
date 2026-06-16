class FavouriteModel {
  final int id;
  final String name;
  final String imageUrl;
  final double price;

  FavouriteModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
    );
  }
}