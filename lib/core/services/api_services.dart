import 'package:dio/dio.dart';

import 'api_exceptions.dart';
import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  ///CRUD METHODS

  /// GET
  Future<dynamic> get(
    String endPoint,
    Map<String, dynamic>? queryParameters,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// POST
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// PUT // UPDATE
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }

  /// DELETE
  Future<dynamic> delete(
    String endPoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dioClient.dio.delete(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      return ApiExceptions.handleError(e);
    }
  }
}
