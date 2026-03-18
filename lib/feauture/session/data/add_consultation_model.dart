class ExpertServiceModel {
  final String titleAr;
  final String titleEn;
  final String? descriptionAr;
  final String? descriptionEn;
  final double price;
  final int durationInMinutes;

  ExpertServiceModel({
    required this.titleAr,
    required this.titleEn,
    this.descriptionAr,
    this.descriptionEn,
    required this.price,
    required this.durationInMinutes,
  });

  Map<String, dynamic> toJson() {
    return {
      "titleAr": titleAr,
      "titleEn": titleEn,
      "descriptionAr": descriptionAr,
      "descriptionEn": descriptionEn,
      "price": price,
      "durationInMinutes": durationInMinutes,
    };
  }
}