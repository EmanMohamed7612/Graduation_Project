
class CategoryofProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;

  CategoryofProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  factory CategoryofProductModel.fromJson(Map<String, dynamic> json) {
    // الطريقة المباشرة أسرع وأمن
    return CategoryofProductModel(
      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? 'No Name',
      description: json['description'] ?? json['Description'] ?? '',
      // تأكدي أن الصورة لا ترجع null أبداً
      image: json['image'] ?? json['Image'] ?? '',
      price: (json['price'] ?? json['Price'] ?? 0).toDouble(),
    );
  }

}