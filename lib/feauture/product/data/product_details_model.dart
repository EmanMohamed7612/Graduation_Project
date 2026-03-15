// class ProductDetailsModel {
//   final int id;
//   final String name;
//   final double price;
//   final int quantity;
//   final String? description;
//   final String? imageUrl;
//   final int categoryId;
//   final String categoryName;
//   final String sellerId;
//   final String sellerName;

//   ProductDetailsModel({
//     required this.id,
//     required this.name,
//     required this.price,
//     required this.quantity,
//     this.description,
//     this.imageUrl,
//     required this.categoryId,
//     required this.categoryName,
//     required this.sellerId,
//     required this.sellerName,
//   });

//   factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
//     return ProductDetailsModel(
//       id: json['id'],
//       name: json['name'],
//       price: (json['price'] as num).toDouble(),
//       quantity: json['quantity'] ?? 0,
//       description: json['description'],
//       imageUrl: json['imageUrl'],
//       categoryId: json['categoryId'],
//       categoryName: json['categoryName'],
//       sellerId: json['sellerId'],
//       sellerName: json['sellerName'],
//     );
//   }
// }
class ProductDetailsModel {
  final int id;
  final String name;
  final num price;
  final int quantity;
  final String? description;
  final String? imageUrl;
  final int categoryId;
  final String categoryName;
  final String sellerId;
  final String sellerName;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.description,
    this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    required this.sellerId,
    required this.sellerName,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] ?? json['Id'],
      name: json['name'] ?? json['Name'],
      price: json['price'] ?? json['Price'],
      quantity: json['quantity'] ?? json['Quantity'] ?? 0,
      description: json['description'] ?? json['Description'],
      imageUrl: json['imageUrl'] ?? json['ImageUrl'], // ✅ String مباشرة
      categoryId: json['categoryId'] ?? json['CategoryId'],
      categoryName: json['categoryName'] ?? json['CategoryName'],
      sellerId: json['sellerId'] ?? json['SellerId'],
      sellerName: json['sellerName'] ?? json['SellerName'],
    );
  }
}
