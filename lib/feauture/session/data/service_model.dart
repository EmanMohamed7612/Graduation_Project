class ServiceModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final int durationInMinutes;

  ServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.durationInMinutes,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id']??json['Id'],
      title: json['title']??json['Title'],
      description: json['description']??json['Description'],
      price: (json['price']??json['Price'] as num).toDouble(),
      durationInMinutes: json['durationInMinutes']??json['DurationInMinutes'],
    );
  }
}



// class Session {
//   final String id;
//   final String userName;
//   final String userImage;
//   final String date;
//   final String time;
//   final String duration;
//   final String? workshopTitle;
//   final String? note;
//   final double? rating;
//   final String? review;

//   Session({
//     required this.id,
//     required this.userName,
//     required this.userImage,
//     required this.date,
//     required this.time,
//     required this.duration,
//     this.workshopTitle,
//     this.note,
//     this.rating,
//     this.review,
//   });
// }