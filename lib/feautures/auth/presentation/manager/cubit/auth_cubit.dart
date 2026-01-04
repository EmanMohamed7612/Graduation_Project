import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final Dio dio =
      Dio(
          BaseOptions(
            // 👇👇 التعديل الحاسم: استخدمنا http بدلاً من https
            baseUrl: "http://craftoria.runasp.net/api/Authentication",
            headers: {"Accept": "application/json"},
            validateStatus: (status) => true,
            connectTimeout: const Duration(seconds: 20),
            receiveTimeout: const Duration(seconds: 20),
          ),
        )
        ..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true),
        );

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    String? yearsOfExperience,
    File? profileImage,
    File? portfolio,
  }) async {
    emit(SignLoadingState());
    print("🚀 محاولة التسجيلاااا (HTTP)...");

    try {
      // بما إن Postman شغال FormData، خلينا زيه بالضبط
      FormData formData = FormData();

      formData.fields.addAll([
        MapEntry("FirstName", firstName.trim()),
        MapEntry("LastName", lastName.trim()),
        MapEntry("Email", email.trim()),
        MapEntry("Password", password),
        MapEntry("ConfirmPassword", confirmPassword),
        MapEntry("Role", role),
        MapEntry("Gender", gender),
        MapEntry("YearsOfExperience", yearsOfExperience?.trim() ?? "0"),
      ]);

      // إضافة الصورة لو موجودة
      // Profile Image
      if (profileImage != null) {
        formData.files.add(
          MapEntry(
            "ProfileImage",
            await MultipartFile.fromFile(profileImage.path),
          ),
        );
      }

// Portfolio
      if (portfolio != null) {
        formData.files.add(
          MapEntry(
            "Portfolio",
            await MultipartFile.fromFile(portfolio.path),
          ),
        );
      }


      final response = await dio.post("/Register", data: formData);

      print("📥 الحالة: ${response.statusCode}");
      print("📄 الرد: ${response.data}");

      if (response.statusCode == 200) {
        if (response.data["success"] == true) {
          emit(
            SignSuccessState(message: response.data["message"] ?? "تم التسجيل"),
          );
        } else {
          emit(
            SignFailureState(
              errorMessage: response.data["message"] ?? "فشل التسجيل",
            ),
          );
        }
      } else {
        String errorMsg = "حدث خطأ غير معروف";
        if (response.data is Map && response.data['message'] != null) {
          errorMsg = response.data['message'];
        }
        emit(SignFailureState(errorMessage: errorMsg));
      }
    } catch (e) {
      print("❌ Error: $e");
      if (e is DioException) {
        emit(SignFailureState(errorMessage: "خطأ في الاتصال: ${e.message}"));
      } else {
        emit(SignFailureState(errorMessage: e.toString()));
      }
    }
  }
}
// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitialState());

//   // 1. إعداد Dio مع HTTPS (ده أهم تعديل)
//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: "https://craftoria.runasp.net/api/Authentication", // 👈 لاحظي حرف s في https
//       headers: {
//         "Accept": "application/json",
//       },
//       // السطر ده بيمنع التطبيق يضرب لو حصل خطأ من السيرفر (زي 400 أو 500)
//       validateStatus: (status) => true,
//       connectTimeout: const Duration(seconds: 20),
//       receiveTimeout: const Duration(seconds: 20),
//     ),
//   )..interceptors.add(LogInterceptor(
//       request: true,
//       requestBody: true,
//       responseBody: true,
//       error: true,
//     )); // عشان نشوف اللوج بالتفصيل
// Future<void> register({
//   required String firstName,
//   required String lastName,
//   required String email,
//   required String password,
//   required String confirmPassword,
//   required String role,
//   required String gender,
//   String? yearsOfExperience,
// }) async {
//   emit(SignLoadingState());
//   print("🚀 بدأ محاولة التسجيل...");

//   try {
//     // 1. إنشاء FormData فارغ
//     FormData formData = FormData();

//     // 2. إضافة البيانات النصية فقط
//     formData.fields.addAll([
//       MapEntry("FirstName", firstName.trim()),
//       MapEntry("LastName", lastName.trim()),
//       MapEntry("Email", email.trim()),
//       MapEntry("Password", password),
//       MapEntry("ConfirmPassword", confirmPassword),
//       MapEntry("Role", role),
//       MapEntry("Gender", gender),
//       MapEntry("YearsOfExperience", yearsOfExperience?.trim() ?? "0"),
//     ]);

//     // 3. (مهم جداً) عدم إضافة مفاتيح الصور إلا لو فيه صورة فعلاً
//     // لو بعتنا ProfileImage: null السيرفر ممكن يعلق
//     // if (profileImage != null) { ... }

//     print("📤 جاري الإرسال إلى: ${dio.options.baseUrl}/Register");

//     // 4. زودنا وقت الانتظار لـ 60 ثانية عشان لو السيرفر نايم
//     final response = await dio.post(
//       "/Register",
//       data: formData,
//       options: Options(
//         sendTimeout: const Duration(seconds: 60),
//         receiveTimeout: const Duration(seconds: 60),
//       ),
//     );

//     print("📥 استقبلنا رد: ${response.statusCode}");
//     print("📄 محتوى الرد: ${response.data}");

//     if (response.statusCode == 200) {
//       if (response.data["success"] == true) {
//         emit(SignSuccessState(message: response.data["message"] ?? "تم بنجاح"));
//       } else {
//         emit(SignFailureState(errorMessage: response.data["message"] ?? "فشل التسجيل"));
//       }
//     } else {
//       // التعامل مع الأخطاء اللي بترجع رد (زي 400 Bad Request)
//       String errorMsg = "حدث خطأ غير معروف";
//       if (response.data is Map && response.data['message'] != null) {
//         errorMsg = response.data['message'];
//       }
//       emit(SignFailureState(errorMessage: errorMsg));
//     }

//   } catch (e) {
//     print("❌ خطأ Dio: $e");
//     if (e is DioException) {
//       if (e.type == DioExceptionType.connectionTimeout || 
//           e.type == DioExceptionType.receiveTimeout ||
//           e.type == DioExceptionType.sendTimeout) {
//         emit(SignFailureState(errorMessage: "السيرفر يأخذ وقتاً طويلاً، حاول مرة أخرى"));
//       } else if (e.response != null) {
//         // لو السيرفر رد برسالة خطأ (زي 400 أو 500)
//         print("خطأ السيرفر: ${e.response?.data}");
//         emit(SignFailureState(errorMessage: "خطأ من السيرفر: ${e.response?.statusCode}"));
//       } else {
//         emit(SignFailureState(errorMessage: "فشل الاتصال، تأكد من الإنترنت"));
//       }
//     } else {
//       emit(SignFailureState(errorMessage: e.toString()));
//     }
//   }
// }
//   // Future<void> register({
//   //   required String firstName,
//   //   required String lastName,
//   //   required String email,
//   //   required String password,
//   //   required String confirmPassword,
//   //   required String role,
//   //   required String gender,
//   //   String? yearsOfExperience,
//   // }) async {
//   //   emit(SignLoadingState());

//   //   try {
//   //     // 2. استخدام FormData المناسب للسيرفر
//   //     FormData formData = FormData.fromMap({
//   //       "FirstName": firstName.trim(),
//   //       "LastName": lastName.trim(),
//   //       "Email": email.trim(),
//   //       "Password": password,
//   //       "ConfirmPassword": confirmPassword,
//   //       "Role": role,
//   //       "Gender": gender,
//   //       "YearsOfExperience": yearsOfExperience ?? "0",
//   //       // Dio ذكي، لو مفيش صورة مش هيبعت مفاتيح غلط تبوظ السيرفر
//   //     });

//   //     print("جاري الإرسال بـ Dio إلى: ${dio.options.baseUrl}/Register");

//   //     final response = await dio.post("/Register", data: formData);

//   //     print("Response Status: ${response.statusCode}");
//   //     print("Response Data: ${response.data}");

//   //     if (response.statusCode == 200) {
//   //       // لو الرد نجاح
//   //       if (response.data["success"] == true) {
//   //         emit(SignSuccessState(message: response.data["message"]));
//   //       } else {
//   //         // لو السيرفر رد بـ 200 بس فيه رسالة خطأ داخلية
//   //         emit(SignFailureState(
//   //             errorMessage: response.data["message"] ?? "فشل التسجيل"));
//   //       }
//   //     } else {
//   //       // لو السيرفر رد بـ 400 Bad Request (وده المتوقع لو فيه بيانات غلط)
//   //       String errorMsg = "حدث خطأ غير معروف";
        
//   //       if (response.data is Map && response.data['message'] != null) {
//   //         errorMsg = response.data['message'];
//   //       } else if (response.data is String) {
//   //         errorMsg = response.data;
//   //       } else if (response.data is Map && response.data['errors'] != null) {
//   //          // أحيانا ASP.NET بيرجع الأخطاء داخل errors
//   //          errorMsg = response.data['errors'].toString();
//   //       }
        
//   //       emit(SignFailureState(errorMessage: errorMsg));
//   //     }
//   //   } catch (e) {
//   //     print("Dio Error: $e");
//   //     if (e is DioException) {
//   //       if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
//   //            emit(SignFailureState(errorMessage: "انتهت مهلة الاتصال بالسيرفر"));
//   //       } else if (e.type == DioExceptionType.connectionError) {
//   //            emit(SignFailureState(errorMessage: "لا يوجد اتصال بالإنترنت أو السيرفر غير متاح"));
//   //       } else {
//   //            emit(SignFailureState(errorMessage: "خطأ في الاتصال: ${e.message}"));
//   //       }
//   //     } else {
//   //       emit(SignFailureState(errorMessage: e.toString()));
//   //     }
//   //   }
//   // }
// }

// import 'dart:async';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http; // ← أضفنا الـ import ده
// import 'dart:convert';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitialState());

//   Future<void> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String role,
//     required String gender,
//     String? yearsOfExperience,
//   }) async {
//     emit(SignLoadingState());
//     print("بدأ التسجيل...");

//     try {
//       // 1. استخدمنا https بدلاً من http
//       // 2. استخدمنا Uri.parse لكتابة الرابط كاملاً
//       final url = Uri.parse(
//         'https://craftoria.runasp.net/api/Authentication/Register',
//       );

//       final request = http.MultipartRequest('POST', url);

//       // الحقول العادية
//       request.fields.addAll({
//         'FirstName': firstName.trim(),
//         'LastName': lastName.trim(),
//         'Email': email.trim(),
//         'Password': password,
//         'ConfirmPassword': confirmPassword,
//         'Role': role,
//         'Gender': gender,
//         'YearsOfExperience': yearsOfExperience?.trim() ?? '',
//       });

//       // الـ headers الصحيحة (مهم بس مش لازم نكتب الـ boundary يدوي)
//       request.headers.addAll({
//         'Accept': 'application/json',
//         'User-Agent': 'Flutter-App',
//       });

//       print("جاري إرسال الطلب إلى: $url");

//       // إرسال الطلب مع timeout كبير
//       final streamedResponse = await request.send().timeout(
//         const Duration(seconds: 50),
//       );

//       final responseBody = await streamedResponse.stream.bytesToString();
//       print("Status Code: ${streamedResponse.statusCode}");
//       print("Response: $responseBody");

//       if (streamedResponse.statusCode == 200 ||
//           streamedResponse.statusCode == 201) {
//         emit(SignSuccessState(message: "تم التسجيل بنجاح"));
//       } else {
//         emit(
//           SignFailureState(
//             errorMessage: responseBody.isNotEmpty
//                 ? responseBody
//                 : "فشل التسجيل (Status: ${streamedResponse.statusCode})",
//           ),
//         );
//       }
//     } catch (e) {
//       print("خطأ في الاتصال: $e");
//       emit(SignFailureState(errorMessage: "فشل الاتصال: $e"));
//     }
//   }
// }
  // دلوقتي بنستخدم http package بدل Dio
  // Future<void> register({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String password,
  //   required String confirmPassword,
  //   required String role,
  //   required String gender,
  //   String? yearsOfExperience,
  // }) async {
  //   emit(SignLoadingState());

  //   print("بدأ التسجيل...");

  //   try {
  //     var uri = Uri.http('craftoria.runasp.net', '/api/Authentication/Register');

  //     var request = http.MultipartRequest('POST', uri);

  //     // البيانات العادية (text fields)
  //     request.fields.addAll({
  //       'FirstName': firstName.trim(),
  //       'LastName': lastName.trim(),
  //       'Email': email.trim(),
  //       'Password': password,
  //       'ConfirmPassword': confirmPassword,
  //       'Role': role,
  //       'Gender': gender,
  //       'YearsOfExperience': yearsOfExperience?.trim() ?? '',
  //     });

  //     print("بعت الطلب للـ API...");
  //     print("الإيميل: $email");

  //     // 30 ثانية timeout عشان لو النت بطيء
  //     var response = await request.send().timeout(const Duration(seconds: 30));

  //     // تحويل الـ response لـ String
  //     var responseBody = await response.stream.bytesToString();
  //     print("Status Code: ${response.statusCode}");
  //     print("Response Body: $responseBody");

  //     // تحليل الـ JSON لو موجود
  //     Map<String, dynamic>? jsonResponse;
  //     try {
  //       jsonResponse = json.decode(responseBody);
  //     } catch (e) {
  //       jsonResponse = null;
  //     }

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       if (jsonResponse != null && jsonResponse["success"] == true) {
  //         emit(SignSuccessState(message: jsonResponse["message"] ?? "تم التسجيل بنجاح"));
  //       } else {
  //         String msg = jsonResponse?["message"] ?? "فشل التسجيل";
  //         emit(SignFailureState(errorMessage: msg));
  //       }
  //     } else {
  //       // أي status تاني = فشل
  //       String errorMsg = jsonResponse?["message"] ?? responseBody;
  //       emit(SignFailureState(errorMessage: errorMsg));
  //     }
  //   } on http.ClientException catch (e) {
  //     print("Client Exception: $e");
  //     emit(SignFailureState(errorMessage: "مشكلة في الاتصال بالسيرفر"));
  //   } on TimeoutException catch (_) {
  //     emit(SignFailureState(errorMessage: "انتهت مهلة الاتصال، النت بطيء أو السيرفر مش شغال"));
  //   } catch (e) {
  //     print("خطأ غير متوقع: $e");
  //     emit(SignFailureState(errorMessage: e.toString()));
  //   }
  // }


// import 'package:dio/dio.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   AuthCubit() : super(AuthInitialState());

//   final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: "http://craftoria.runasp.net/api/Authentication",
//       headers: {"Accept": "application/json"},
//       followRedirects: false,
//       validateStatus: (status) => true,
//     ),
//   );

//   Future<void> register({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required String role,
//     required String gender,
//     String? yearsOfExperience,
//   }) async {
//     emit(SignLoadingState()); // ← مهم جدااا

//     try {
//       FormData formData = FormData.fromMap({
//         "FirstName": firstName,
//         "LastName": lastName,
//         "Email": email,
//         "Password": password,
//         "ConfirmPassword": confirmPassword,
//         "Role": role,
//         "Gender": gender,
//         "YearsOfExperience": yearsOfExperience,
//         "Portfolio": null,
//         "ProfileImage": null,
//       });

//       final response = await dio.post("/Register", data: formData);

//       print("SUCCESS: ${response.data}");

//       if (response.statusCode == 200 && response.data["success"] == true) {
//         emit(SignSuccessState(message: response.data["message"]));
//       } else {
//         emit(
//           SignFailureState(
//             errorMessage: response.data["message"] ?? "Unknown error",
//           ),
//         );
//       }
//     } catch (e) {
//       if (e is DioException) {
//         print("DIO ERROR: ${e.response?.data}");
//         print("STATUS: ${e.response?.statusCode}");
//         emit(
//           SignFailureState(
//             errorMessage: e.response?.data.toString() ?? "Network error",
//           ),
//         );
//       } else {
//         emit(SignFailureState(errorMessage: e.toString()));
//       }
//     }
//   }
// }


// // import 'dart:convert';
// // import 'dart:io';

// // import 'package:dio/dio.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // part 'auth_state.dart';





// // class AuthCubit extends Cubit<AuthState> {
// //   AuthCubit() : super(AuthInitialState());
// //   final Dio dio = Dio(
// //     BaseOptions(
// //       baseUrl: "https://craftoria.runasp.net/api/Authentication",
// //       headers: {"Accept": "application/json"},
// //       followRedirects: false,
// //     validateStatus: (status) => true,
// //     ),
// //   );

// //   Future register({
// //     required String firstName,
// //     required String lastName,
// //     required String email,
// //     required String password,
// //     required String confirmPassword,
// //     required String role,
// //     required String gender,
// //      String? yearsOfExperience,
// //   }) async {
// //     try {
// //       FormData formData = FormData.fromMap({
// //         "FirstName": firstName,
// //         "LastName": lastName,
// //         "Email": email,
// //         "Password": password,
// //         "ConfirmPassword": confirmPassword,
// //         "Role": role,
// //         "Gender": gender,
// //         "YearsOfExperience": yearsOfExperience,

// //         // بدون صور
// //         "Portfolio": null,
// //         "ProfileImage": null,
// //       });

// //       final response = await dio.post("/Register", data: formData);

// //       print("SUCCESS: ${response.data}");
// //       return response.data;
// //     } catch (e) {
// //       if (e is DioException) {
// //         print("DIO ERROR: ${e.response?.data}");
// //         print("STATUS: ${e.response?.statusCode}");
// //       }
// //       rethrow;
// //     }
// //   }
// // }


// // // import 'dart:convert';
// // // import 'dart:io';

// // // import 'package:bloc/bloc.dart';
// // // import 'package:dio/dio.dart';
// // // import 'package:meta/meta.dart';

// // // part 'auth_state.dart';

// // // class AuthCubit extends Cubit<AuthState> {
// // //   AuthCubit() : super(AuthInitialState());
// // //   static const String baseUrl = "http://craftoria.runasp.net/api/";

// // //   // void registerUser({
// // //   //   required String firstName,
// // //   //   required String lastName,
// // //   //   required String email,
// // //   //   required String password,
// // //   //   required String confirmPassword,
// // //   //   required String role,
// // //   //   required String gender,
// // //   //   String? yearsOfExperience,
// // //   //   File? profileImage,
// // //   //   File? portfolio,
// // //   // }) async {
// // //   //   emit(SignLoadingState());
// // //   //   try {
// // //   //     // FormData formData = FormData.fromMap({
// // //   //     //   "FirstName": firstName,
// // //   //     //   "LastName": lastName,
// // //   //     //   "Email": email,
// // //   //     //   "Password": password,
// // //   //     //   "ConfirmPassword": confirmPassword,
// // //   //     //   "Role": role,
// // //   //     //   "Gender": gender,
// // //   //     //   "YearsOfExperience": yearsOfExperience,
// // //   //     //   "ProfileImage": null,
// // //   //     //   "Portfolio": null,
// // //   //     // });
// // //   //     final data = {
// // //   //       "FirstName": firstName,
// // //   //       "LastName": lastName,
// // //   //       "Email": email,
// // //   //       "Password": password,
// // //   //       "ConfirmPassword": confirmPassword,
// // //   //       "Role": role,
// // //   //       "Gender": gender,
// // //   //       "YearsOfExperience": null,
// // //   //       "ProfileImage": null,
// // //   //       "Portfolio": null,
// // //   //     };

// // //   //     Response response =
// // //   //         await Dio(
// // //   //           BaseOptions(
// // //   //             connectTimeout: Duration(seconds: 10),
// // //   //             receiveTimeout: Duration(seconds: 10),
// // //   //           ),
// // //   //         ).post(
// // //   //           "http://craftoria.runasp.net/api/Authentication/Register",
// // //   //           data: data,
// // //   //           options: Options(headers: {"Content-Type": "application/json"}),
// // //   //         );
// // //   //     if (response.data["success"] == true) {
// // //   //       emit(SignSuccessState());
// // //   //       print('ggggggggggggggggggggg');
// // //   //     } else {
// // //   //       emit(
// // //   //         SignFailureState(response.data["message"] ?? "Registration failed"),
// // //   //       );
// // //   //     }
// // //   //   } catch (e) {
// // //   //     if (e is DioException) {
// // //   //       print("DIO ERROR: ${e.response?.data}");
// // //   //       print("STATUS: ${e.response?.statusCode}");

// // //   //       final errorMessage =
// // //   //           e.response?.data?.toString() ??
// // //   //           e.message ??
// // //   //           "Something went wrong. Please try again.";

// // //   //       emit(SignFailureState(errorMessage));
// // //   //     } else {
// // //   //       emit(SignFailureState(e.toString()));
// // //   //     }
// // //   //   }

// // //   //   //  catch (e) {
// // //   //   //   emit(SignFailureState(e.toString()));
// // //   //   // }
// // //   // }
// // // void registerUser({
// // //   required String firstName,
// // //   required String lastName,
// // //   required String email,
// // //   required String password,
// // //   required String confirmPassword,
// // //   required String role,
// // //   required String gender,
// // //   String? yearsOfExperience,
// // //   File? profileImage,
// // //   File? portfolio,
// // // }) async {

// // //   emit(SignLoadingState());

// // //   try {
// // //     FormData formData = FormData.fromMap({
// // //       "FirstName": firstName,
// // //       "LastName": lastName,
// // //       "Email": email,
// // //       "Password": password,
// // //       "ConfirmPassword": confirmPassword,
// // //       "Role": role,
// // //       "Gender": gender,
// // //       "YearsOfExperience": yearsOfExperience ?? "0",

// // //       // لازم حتى لو null
// // //       "ProfileImage": profileImage != null
// // //           ? await MultipartFile.fromFile(profileImage.path)
// // //           : null,

// // //       "Portfolio": portfolio != null
// // //           ? await MultipartFile.fromFile(portfolio.path)
// // //           : null,
// // //     });

// // //     Response response = await Dio().post(
// // //       "http://craftoria.runasp.net/api/Authentication/Register",
// // //       data: formData,
// // //       options: Options(
// // //         headers: {
// // //           "accept": "*/*",
// // //           "Content-Type": "multipart/form-data",
// // //         },
// // //       ),
// // //     );

// // //     print("RESPONSE: ${response.data}");

// // //     /// تعديل هنا حسب API بتاعكم
// // //     if (response.statusCode == 200) {
// // //       emit(SignSuccessState());
// // //     } else {
// // //       emit(SignFailureState(
// // //           response.data["message"] ?? "Registration failed"));
// // //     }
// // //   } catch (e) {
// // //     if (e is DioException) {
// // //       print("DIO ERROR: ${e.response?.data}");
// // //       print("STATUS: ${e.response?.statusCode}");

// // //       emit(SignFailureState(
// // //         e.response?.data?["message"]?.toString() ??
// // //             "Something went wrong",
// // //       ));
// // //     } else {
// // //       emit(SignFailureState(e.toString()));
// // //     }
// // //   }
// // // }


// // // }
