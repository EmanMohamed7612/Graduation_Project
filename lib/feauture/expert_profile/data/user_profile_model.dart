class UserProfileModel {
  final String id;
  final String firstName;
  final String secondName;
  final String userName;
  final String email;
  final String? profileImage;
  final String bio;
  final String? specialization;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.userName,
    required this.email,
    this.profileImage,
    required this.bio,
    this.specialization,
  });

  // Computed property للاسم الكامل
  String get fullName => '$firstName $secondName';

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] ?? '',
      firstName: json['firstName'] ?? '',
      secondName: json['secondName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'],
      bio: json['bio'] ?? '',
      specialization: json['specialization'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'secondName': secondName,
      'userName': userName,
      'email': email,
      'profileImage': profileImage,
      'bio': bio,
      'specialization': specialization,
    };
  }
}