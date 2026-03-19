/// Request Model for Create Product
class CreatematerialRequestModel {
  final String nameEn;
  final String nameAr;
  final int price;
  final int quantity;
  final String description;
  final int categoryId;
  final String imageFile;
  final List<String> tags;

  CreatematerialRequestModel({
    required this.nameEn,
    required this.nameAr,
    required this.price,
    required this.quantity,
    required this.description,
    required this.categoryId,
    required this.imageFile,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'NameEn': nameEn,
      'NameAr': nameAr,
      'Price': price,
      'Quantity': quantity,
      'Description': description,
      'CategoryId': categoryId,
      'ImageFile': imageFile,
      'Tgs': tags,
    };
  }
}

/// Response Model for Create Product
class CreatematerialResponseModel {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String description;
  final String imageUrl;
  final int categoryId;
  final String categoryName;
  final String sellerId;
  final String? sellerName;

  CreatematerialResponseModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    required this.sellerId,
    this.sellerName,
  });

  factory CreatematerialResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return CreatematerialResponseModel(
      id: data['id'],
      name: data['name'],
      price: (data['price'] as num).toDouble(),
      quantity: data['quantity'],
      description: data['description'],
      imageUrl: data['imageUrl'],
      categoryId: data['categoryId'],
      categoryName: data['categoryName'],
      sellerId: data['sellerId'],
      sellerName: data['sellerName'],
    );
  }
}
