class ProductModel {
  final String? sellerId;
  final int? id;
  final String? imagePath;
  final String name;
  final String price;
  final String stock;
  final String category;
  final String description;

  ProductModel({
    this.imagePath,
    required this.name,
    required this.price,
    required this.stock,
    required this.category,
    required this.description,
    this.id,
    this.sellerId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      // السيرفر قد يرسلها Id أو id، هذا السطر يعالج الحالتين
      ///////////
      ///id: (json['Id'] ?? json['id'])?.toString(),
      id: (json['Id'] ?? json['id']),
      name: json['Name'] ?? json['name'] ?? '',
      price: (json['Price'] ?? json['price'])?.toString() ?? '',
      stock: (json['Quantity'] ?? json['quantity'] ?? json['stock'])?.toString() ?? '',
      category: (json['CategoryId'] ?? json['categoryId'] ?? json['category'])?.toString() ?? '',
      description: json['Description'] ?? json['description'] ?? '',
      imagePath: json['ImagePath'] ?? json['image'] ?? json['imageUrl'],
      sellerId: (json['SellerId'] ?? json['sellerId'])?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'Id': id,
      'Name': name,
      'Price': price,
      'Quantity': stock,
      'CategoryId': category,
      'Description': description,
      if (sellerId != null) 'SellerId': sellerId,
    };
  }
}