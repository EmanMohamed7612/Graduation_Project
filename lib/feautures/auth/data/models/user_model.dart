import 'dart:io';

import 'package:dio/dio.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String role;
  final String gender;
  final File? portfolio;
  final String? yearsOfExperience;
  final File? profileImage;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.role,
    required this.gender,
    this.portfolio,
    this.yearsOfExperience,
    this.profileImage,
  });

  FormData toFormData(UserModel uderModel) {
    return FormData.fromMap({
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "Password": password,
        "ConfirmPassword": confirmPassword,
        "Role": role,
        "Gender": gender,
        "YearsOfExperience": null,
        "ProfileImage": null,
        "Portfolio": null,
      });
  }
}
