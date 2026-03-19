class SearchProductModel {
  final int id;
  final String name;
  final String image;

  SearchProductModel({required this.id, required this.name, required this.image});

  factory SearchProductModel.fromJson(Map<String, dynamic> json) {
    return SearchProductModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}