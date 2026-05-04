class UserAccountModel {
  final String id;
  final String firstName;
  final String secondName;

  // final String userName;
  // final String email;
  final String? picturUrl;
  final String bio;
  final String? specialization;
  final String? role;


  UserAccountModel({
    required this.id,
    required this.firstName,
    required this.secondName,

    //  required this.userName,
    //  required this.email,

    this.picturUrl,
    required this.bio,
    this.specialization,
    required this.role,
  });

  // Computed property للاسم الكامل
  String get fullName => '$firstName $secondName';

  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      id: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      secondName: json['secondName'] ?? '',

      // userName: json['userName'] ?? '',
      //  email: json['email'] ?? '',
      picturUrl: json['picturUrl'] ?? '',

      bio: json['bio'] ?? '',
      role: json['role'] ?? '',
      specialization: json['specialization'],
    );
  }
String? get profileImage => picturUrl;
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'secondName': secondName,

      // 'userName': userName,

      //'email': email,
      'picturUrl': picturUrl,
      'bio': bio,
      'specialization': specialization,
      'role': role,
    };
  }
}
