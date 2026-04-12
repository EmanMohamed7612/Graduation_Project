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
    // وظيفة مساعدة للبحث عن المفتاح سواء كان كابيتال أو سمول
    dynamic getValue(String key) {
      // يبحث عن المفتاح بالظبط، ثم يبحث عنه بسمول، ثم يبحث عنه بكابيتال
      return json[key] ?? json[key.toLowerCase()] ?? json[key[0].toUpperCase() + key.substring(1)];
    }

    return CategoryofProductModel(
      id: getValue('id') ?? 0,
      name: getValue('name') ?? 'No Name',
      description: getValue('description') ?? '',
      image: getValue('image') ?? '', // سيجد 'image' أو 'Image'
      price: (getValue('price') ?? 0).toDouble(),
    );
  }
}