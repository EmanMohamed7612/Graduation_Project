class SearchcategoryModel {
  final int id;
  final String name;
  final String image;

  SearchcategoryModel({required this.id, required this.name, required this.image});

  factory SearchcategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchcategoryModel(

      id: json['id'] ?? json['Id'] ?? 0,
      name: json['name'] ?? json['Name'] ?? '',
      image: json['image'] ?? json['Image'] ?? '',

    );
  }
}