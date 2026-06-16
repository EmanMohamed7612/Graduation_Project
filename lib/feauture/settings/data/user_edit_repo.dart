// import 'package:dio/dio.dart';
// import 'dart:io';

// import 'package:graduation2/core/services/api_services.dart';

// extension UserProfileUpdate on UserProfileRepo {
//   Future<void> updateUserProfile({
//     String? firstName,
//     String? lastName,
//     String? bio,
//     int? gender,
//     String? specialization,
//     File? imageFile,
//   }) async {
//     // تجهيز البيانات كـ Map
//     Map<String, dynamic> data = {
//       "FirstName": firstName,
//       "LastName": lastName,
//       "Bio": bio,
//       "Gender": gender,
//       "Specialization": specialization,
//     };

//     // إضافة الصورة إذا وجدت
//     if (imageFile != null) {
//       data["ProfileImage"] = await MultipartFile.fromFile(
//         imageFile.path,
//         filename: imageFile.path.split('/').last,
//       );
//     }

//     // تحويل الـ Map لـ FormData
//     FormData formData = FormData.fromMap(data);

//     final response = await _apiService.post('/api/UserProfile', formData);

//     if (response is Map<String, dynamic> && response['succeeded'] == true) {
//       return; // نجاح
//     } else {
//       throw Exception(response['message'] ?? "Update failed");
//     }
//   }
// }