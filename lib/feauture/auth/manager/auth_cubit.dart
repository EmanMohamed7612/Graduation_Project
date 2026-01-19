import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_services.dart';
import '../data/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final ApiService apiService;

  AuthCubit(this.apiService) : super(AuthInitialState());

  // Helper method to parse response
  Map<String, dynamic>? _parseResponse(dynamic response) {
    if (response == null) return null;

    if (response is Map<String, dynamic>) {
      return response;
    } else if (response is String) {
      try {
        return jsonDecode(response) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Check if response contains an error
  String? _extractErrorMessage(Map<String, dynamic> jsonData) {
    // Check if success is explicitly false
    if (jsonData['success'] == false) {
      // First check errors object
      if (jsonData['errors'] != null) {
        final errors = jsonData['errors'];
        if (errors is Map<String, dynamic>) {
          // Try to get errorMessage
          if (errors['errorMessage'] != null) {
            return errors['errorMessage'].toString();
          }
          // Try to get message
          if (errors['message'] != null) {
            return errors['message'].toString();
          }
        }
        // If errors is a string
        if (errors is String) {
          return errors;
        }
      }
      // Then check message field
      if (jsonData['message'] != null &&
          jsonData['message'] != 'Internal Server Error') {
        return jsonData['message'].toString();
      }

      return 'An error occurred';
    }
    return null;
  }

  // Extract user data from API response structure
  Map<String, dynamic>? _extractUserData(Map<String, dynamic> jsonData) {
    // Check if response has the standard API structure with 'data' field
    if (jsonData.containsKey('data') && jsonData['data'] != null) {
      final data = jsonData['data'];
      if (data is Map<String, dynamic>) {
        return data;
      }
    }
    // Otherwise return the jsonData itself
    return jsonData;
  }

  // Register Function
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
     int? yearsOfExperience,
    List<String>? profileImage,
    List<String>? portfolio,
  }) async {
    emit(AuthLoadingState());

    try {
      final userData = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        role: role,
        gender: gender,
        yearsOfExperience: yearsOfExperience,
        profileImage: profileImage,
        portfolio: portfolio,
      );

      final response = await apiService.post(
        ApiEndpoint.Register,
        userData.toJson(),
      );

      // Check if response is ApiError
      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      // Parse response
      final jsonData = _parseResponse(response);

      if (jsonData == null) {
        emit(AuthSuccessState(userData));
        return;
      }

      // Check for API errors
      final errorMessage = _extractErrorMessage(jsonData);
      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      // Extract user data from response
      final userDataMap = _extractUserData(jsonData);

      if (userDataMap != null) {
        final user = UserModel.fromJson(userDataMap);
        emit(AuthSuccessState(user));
      } else {
        emit(AuthSuccessState(userData));
      }
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // Register with FormData (for file uploads)
  Future<void> registerWithFiles({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
    required String gender,
    required int yearsOfExperience,
    List<MultipartFile>? profileImages,
    List<MultipartFile>? portfolioFiles,
  }) async {
    emit(AuthLoadingState());

    try {
      final formData = FormData.fromMap({
        'FirstName': firstName,
        'LastName': lastName,
        'Email': email,
        'Password': password,
        'ConfirmPassword': confirmPassword,
        'Role': role,
        'Gender': gender,
        if (role == 'Expert' && yearsOfExperience != null)
          'YearsOfExperience': yearsOfExperience,
        if (profileImages != null) 'ProfileImage': profileImages,
        if (portfolioFiles != null) 'Portfolio': portfolioFiles,
      });
      if (role == 'Expert' && yearsOfExperience != null) {
        formData.fields.add(
          MapEntry('YearsOfExperience', yearsOfExperience.toString()),
        );
      }
      final response = await apiService.post(ApiEndpoint.Register, formData);

      // Check if response is ApiError
      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      // Parse response
      final jsonData = _parseResponse(response);

      if (jsonData == null) {
        final user = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          role: role,
          gender: gender,
          yearsOfExperience: yearsOfExperience,
        );
        emit(AuthSuccessState(user));
        return;
      }

      // Check for API errors
      final errorMessage = _extractErrorMessage(jsonData);
      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      // Extract user data from response
      final userDataMap = _extractUserData(jsonData);

      if (userDataMap != null) {
        final user = UserModel.fromJson(userDataMap);
        emit(AuthSuccessState(user));
      } else {
        final user = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
          role: role,
          gender: gender,
          yearsOfExperience: yearsOfExperience,
        );
        emit(AuthSuccessState(user));
      }
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // Login Function
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final response = await apiService.post(ApiEndpoint.login, {
        'Email': email,
        'Password': password,
      });

      // Check if response is ApiError
      if (response is ApiError) {
        emit(AuthFailureState(response.message));
        return;
      }

      // Parse response
      final jsonData = _parseResponse(response);

      if (jsonData == null) {
        emit(AuthFailureState('Invalid response from server'));
        return;
      }

      // Check for API errors
      final errorMessage = _extractErrorMessage(jsonData);
      if (errorMessage != null) {
        emit(AuthFailureState(errorMessage));
        return;
      }

      // Extract user data from response
      final userDataMap = _extractUserData(jsonData);

      if (userDataMap != null) {
        final user = UserModel.fromJson(userDataMap);
        emit(AuthSuccessState(user));
      } else {
        emit(AuthFailureState('Invalid user data from server'));
      }
    } catch (e) {
      emit(AuthFailureState('Unexpected error: $e'));
    }
  }

  // Logout Function
  void logout() {
    emit(AuthInitialState());
  }

  // Reset State
  void resetState() {
    emit(AuthInitialState());
  }
}
