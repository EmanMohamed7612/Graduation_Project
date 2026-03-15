import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:graduation2/feauture/review/data/add_review_model.dart';
import 'package:graduation2/feauture/review/data/product_review_model.dart';
import 'package:graduation2/feauture/review/data/product_state_model.dart';
import 'package:graduation2/feauture/review/data/review_response.dart';
import 'package:graduation2/feauture/review/data/user_state_model.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/services/dio_client.dart';

class ReviewApiService {
  final DioClient _dioClient = DioClient();

  // Future<ReviewResponse?> addOrUpdateReview(AddReviewRequest request) async {
  //   try {
  //     log('📤 Adding / Updating Review');

  //     final response = await _dioClient.dio.post(
  //       '/api/Reviews/AddOrUpdateReview',
  //       data: request.toJson(),
  //     );

  //     if (response.statusCode == 200 && response.data != null) {
  //       final data = response.data['data'];
  //       return ReviewResponse.fromJson(data);
  //     }

  //     return null;
  //   } on DioException catch (e) {
  //     log('❌ Review Error: ${e.response?.data}');
  //     throw ApiExceptions.handleError(e);
  //   } catch (e) {
  //     log('❌ Unexpected Review Error: $e');
  //     rethrow;
  //   }
  // }
  Future<ReviewResponse?> addOrUpdateReview(AddReviewRequest request) async {
    try {
      log('📤 Adding / Updating Review');

      final response = await _dioClient.dio.post(
        '/api/Reviews/AddOrUpdateReview',
        data: request.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];

        if (data == null) {
          log('❌ API returned null data');
          return null;
        }

        return ReviewResponse.fromJson(data);
      }

      return null;
    } on DioException catch (e) {
      log('❌ Review Error: ${e.response?.data}');
      throw ApiExceptions.handleError(e);
    } catch (e) {
      log('❌ Unexpected Review Error: $e');
      rethrow;
    }
  }

  Future<List<ProductReviewModel>> getProductReviews(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetProductReviews',
        queryParameters: {
          'productId': productId,
          't': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(headers: {'Cache-Control': 'no-cache'}),
      );
      print("RESPONSE = ${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        List responseList = [];

        // بنشيك لو الداتا راجعة List مباشرة
        if (response.data is List) {
          responseList = response.data;
        }
        // ولو راجعة جوه Object اسمه data
        else if (response.data is Map) {
          responseList = response.data['data'] ?? response.data['Data'] ?? [];
        }

        return responseList.map((e) => ProductReviewModel.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
    //   if (response.statusCode == 200 && response.data != null) {
    //     //   final List list = response.data['data'];
    //     //   return list.map((e) => ProductReviewModel.fromJson(e)).toList();
    //     // }

    //     // return [];
    //     if (response.data['data'] == null) {
    //       return [];
    //     }

    //     final List list = response.data['data'];

    //     return list.map((e) => ProductReviewModel.fromJson(e)).toList();
    //   }

    //   return [];
    // } on DioException catch (e) {
    //   throw ApiExceptions.handleError(e);
    // }
  }

  Future<List<ProductReviewModel>> getRawMatrialReviews(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetRawMaterialReviews',
        queryParameters: {
          'materialId': productId,
          't': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(headers: {'Cache-Control': 'no-cache'}),
      );
      print("RESPONSE = ${response.data}");
      if (response.statusCode == 200 && response.data != null) {
        List responseList = [];

        // بنشيك لو الداتا راجعة List مباشرة
        if (response.data is List) {
          responseList = response.data;
        }
        // ولو راجعة جوه Object اسمه data
        else if (response.data is Map) {
          responseList = response.data['data'] ?? response.data['Data'] ?? [];
        }

        return responseList.map((e) => ProductReviewModel.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
    //   if (response.statusCode == 200 && response.data != null) {
    //     //   final List list = response.data['data'];
    //     //   return list.map((e) => ProductReviewModel.fromJson(e)).toList();
    //     // }

    //     // return [];
    //     if (response.data['data'] == null) {
    //       return [];
    //     }

    //     final List list = response.data['data'];

    //     return list.map((e) => ProductReviewModel.fromJson(e)).toList();
    //   }

    //   return [];
    // } on DioException catch (e) {
    //   throw ApiExceptions.handleError(e);
    // }
  }

  Future<List<ProductReviewModel>> getUserReviews(String targetUserId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetUserReviews',
        queryParameters: {
          'targetUserId': targetUserId,
          't': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(headers: {'Cache-Control': 'no-cache'}),
      );

      log('📥 GetUserReviews Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        List responseList = [];

        // بنشيك لو الداتا راجعة List مباشرة
        if (response.data is List) {
          responseList = response.data;
        }
        // ولو راجعة جوه Object اسمه data
        else if (response.data is Map) {
          responseList = response.data['data'] ?? response.data['Data'] ?? [];
        }

        return responseList.map((e) => ProductReviewModel.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  // Future<List<ProductReviewModel>> getUserReviews(String targetUserId) async {
  //   try {
  //     final response = await _dioClient.dio.get(
  //       '/api/Reviews/GetUserReviews',
  //       queryParameters: {'targetUserId': targetUserId},
  //     );

  //     if (response.statusCode == 200 && response.data != null) {

  //       //     final List list = response.data['data'];
  //       //     return list.map((e) => ProductReviewModel.fromJson(e)).toList();
  //       //   }

  //       //   return [];
  //       // }
  //       //// إضافة هذا الشرط لحل مشكلة الـ Null
  //       if (response.data['data'] == null) {
  //         return [];
  //       }
  //       final List list = response.data['data'];
  //       return list.map((e) => ProductReviewModel.fromJson(e)).toList();
  //     }

  //     return [];
  //   } on DioException catch (e) {
  //     throw ApiExceptions.handleError(e);
  //   }
  // }

  Future<List<ProductReviewModel>> getCreatedReviews(
    String targetUserId,
  ) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/UserProfile/GetAllReviewThatCreatedBySpecificUser',
        queryParameters: {
          'userId': targetUserId,
          't': DateTime.now().millisecondsSinceEpoch,
        },
        options: Options(headers: {'Cache-Control': 'no-cache'}),
      );

      log('📥 GetUserReviews Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        List responseList = [];

        // بنشيك لو الداتا راجعة List مباشرة
        if (response.data is List) {
          responseList = response.data;
        }
        // ولو راجعة جوه Object اسمه data
        else if (response.data is Map) {
          responseList = response.data['data'] ?? response.data['Data'] ?? [];
        }

        return responseList.map((e) => ProductReviewModel.fromJson(e)).toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<ProductStatsModel?> getProductStats(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetProductStats',
        queryParameters: {'productId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return ProductStatsModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<UserStateModel?> getUserState(String productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetUserStats',
        queryParameters: {'targetUserId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserStateModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  Future<UserStateModel?> getRawMatrialState(int productId) async {
    try {
      final response = await _dioClient.dio.get(
        '/api/Reviews/GetRawMaterialStats',
        queryParameters: {'materialId': productId},
      );

      if (response.statusCode == 200 && response.data != null) {
        return UserStateModel.fromJson(response.data['data']);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
}
