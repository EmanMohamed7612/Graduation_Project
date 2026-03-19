class SearchcategoryModel {
  final int id;
  final String name;
  final String image;

  SearchcategoryModel({required this.id, required this.name, required this.image});

  factory SearchcategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchcategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}