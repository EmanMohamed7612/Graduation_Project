// class CartItem {
//   final String title;
//   final String subtitle;
//   final String image;
//   final double price;
//   int quantity;

//   CartItem({
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     required this.price,
//     required this.quantity,
//   });
// }
class CartDto {
  final String id;
  final List<CartItemDto> cartItems;

  CartDto({required this.id, required this.cartItems});

  factory CartDto.fromJson(Map<String, dynamic> json) {
    return CartDto(
      id: json['id'],
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartItemDto.fromJson(e))
          .toList(),
    );
  }
}

class CartItemDto {
  final int id;
  final String itemName;
  final String? pictureURL;
  final String? category;
  final int? categoryId;
  final double price;
  final int quantity;

  CartItemDto({
    required this.id,
    required this.itemName,
    required this.price,
    required this.quantity,
    this.pictureURL,
    this.category,
    this.categoryId,
  });

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    return CartItemDto(
      id: json['id'],
      itemName: json['itemName'],
      pictureURL: json['pictureURL'],
      category: json['category'],
      categoryId: json['categoryId'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }
}
