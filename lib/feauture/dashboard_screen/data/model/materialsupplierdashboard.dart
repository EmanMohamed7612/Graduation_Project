
/*class materialsupplierdashboardModel {
=======
class materialsupplierdashboardModel {
>>>>>>> origin/book-session
  final int id;
  final String name;
  final double price;
  final int stock;
  final String image;
  final String description;
  final int categoryId;
  final String? categoryName;

  materialsupplierdashboardModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.categoryName,
  });

  factory materialsupplierdashboardModel.fromJson(Map<String, dynamic> json) {
    return materialsupplierdashboardModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      stock: json['quantity'] ?? 0,
      image: json['imageUrl'] ?? "",
      description: json['description'] ?? "",
      categoryId: json['categoryId'] ?? 0,
      categoryName: json['categoryName'] ?? '',    );
  }

}*/
class materialsupplierdashboardModel {
  final int id;
  final String name;
  final double price;
  final int stock;
  final String image;
  final String description;
  final int categoryId;
  final String? categoryName;

  materialsupplierdashboardModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.categoryName,
  });

  factory materialsupplierdashboardModel.fromJson(Map<String, dynamic> json) {
    // وظيفة داخلية للبحث عن المفتاح بغض النظر عن حالة الأحرف (Capital/Small)
    dynamic getValue(Map<String, dynamic> map, String key) {
      String targetKey = key.toLowerCase();
      for (var entry in map.entries) {
        if (entry.key.toLowerCase() == targetKey) {
          return entry.value;
        }
      }
      return null;
    }

    return materialsupplierdashboardModel(
      id: getValue(json, 'id') ?? 0,
      name: getValue(json, 'name') ?? "",
      price: (getValue(json, 'price') ?? 0).toDouble(),
      // بيبحث عن 'quantity' أو 'stock' عشان لو الاسم اتغير في الـ API
      stock: getValue(json, 'quantity') ?? getValue(json, 'stock') ?? 0,
      // بيبحث عن 'imageUrl' أو 'image'
      image: getValue(json, 'imageUrl') ?? getValue(json, 'image') ?? "",
      description: getValue(json, 'description') ?? "",
      categoryId: getValue(json, 'categoryId') ?? 0,
      categoryName: getValue(json, 'categoryName') ?? '',
    );
  }


}
