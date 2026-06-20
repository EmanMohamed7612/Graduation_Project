import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graduation2/core/const/api_endpoint.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/profile/data/user_account_model.dart';
import 'package:graduation2/feauture/profile/data/user_profile_model.dart';

class UserProfileRepo {
  final ApiService _apiService = ApiService();
  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? bio,
    int? gender,
    String? specialization,
    File? imageFile,
  }) async {
    try {
      // تجهيز البيانات
      Map<String, dynamic> data = {
        "FirstName": firstName,
        "LastName": lastName,
        "Bio": bio,
        "Gender": gender,
        "Specialization": specialization,
      };

      // تحويل الصورة لـ MultipartFile إذا وجدت
      if (imageFile != null) {
        data["ProfileImage"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      // تحويل الخريطة إلى FormData
      FormData formData = FormData.fromMap(data);

      // إرسال الطلب
      final response = await _apiService.post(
        ApiEndpoint.userProfile,
        formData,
      );

      // التحقق من النجاح
      if (response != null && response['success'] == true) {
        return;
      } else {
        throw Exception(response['message'] ?? "Update failed");
      }
    } catch (e) {
      rethrow;
    }
  }

  // 2. الميثود القديمة (تأكدي من وجود الأقواس بعد الاسم)
  Future<UserProfileModel> getCurrentUser() async {
    final response = await _apiService.get(ApiEndpoint.userProfile, null);
    // ... باقي الكود
    if (response is Map<String, dynamic>) {
      final data = response['data'];
      return UserProfileModel.fromJson(data);
    }
    throw Exception("Failed to fetch profile");
  }

  Future<UserAccountModel> getAccountById(String userId) async {
    final response = await _apiService.get(ApiEndpoint.getUserAccount, {
      'userId': userId,
    });

    if (response is Map<String, dynamic>) {
      final data = response['data'];
      if (data != null) {
        return UserAccountModel.fromJson(data);
      }
    }

    throw ApiError(message: 'Failed to fetch account');
  }
}
