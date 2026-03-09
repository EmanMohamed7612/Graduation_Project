// import 'package:dio/dio.dart';
// import 'package:graduation2/core/services/api_error.dart';
// import 'package:graduation2/feauture/profile/data/user_profile_model.dart';
// import 'package:graduation2/feauture/product_screens/data/model/creatprodect_model.dart';

// import 'api_exceptions.dart';
// import 'dio_client.dart';

// class ApiService {
//   final DioClient _dioClient = DioClient();

//   ///CRUD METHODS

//   /// GET
//   Future<dynamic> get(
//     String endPoint,
//     Map<String, dynamic>? queryParameters,
//   ) async {
//     try {
//       final response = await _dioClient.dio.get(
//         endPoint,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       return ApiExceptions.handleError(e);
//     }
//   }

//   /// POST
//   Future<dynamic> post(String endPoint, dynamic body) async {
//     try {
//       final response = await _dioClient.dio.post(endPoint, data: body);
//       return response.data;
//     } on DioException catch (e) {
//       return ApiExceptions.handleError(e);
//     }
//   }

//   /// PUT // UPDATE
//   Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
//     try {
//       final response = await _dioClient.dio.put(endPoint, data: body);
//       return response.data;
//     } on DioException catch (e) {
//       return ApiExceptions.handleError(e);
//     }
//   }

//   /// DELETE
//   Future<dynamic> delete(
//     String endPoint, {
//     Map<String, dynamic>? body,
//     Map<String, dynamic>? queryParameters,
//   }) async {
//     try {
//       final response = await _dioClient.dio.delete(
//         endPoint,
//         data: body,
//         queryParameters: queryParameters,
//       );
//       return response.data;
//     } on DioException catch (e) {
//       return ApiExceptions.handleError(e);
//     }
//   }
// }

// class UserProfileRepo {
//   final ApiService _apiService = ApiService();

//   Future<UserProfileModel> getCurrentUser() async {
//     final response = await _apiService.get(
//       '/api/UserProfile',
//       null,
//     );

//     if (response is ApiError) {
//       throw response;
//     }

//     // ⚠️ FIX: Handle the nested "data" structure properly
//     if (response is Map<String, dynamic>) {
//       // Check if response has success = false
//       if (response['success'] == false) {
//         final errorMsg = response['errors']?['errorMessage'] ??
//                         response['message'] ??
//                         'Failed to fetch profile';
//         throw ApiError;
//       }

//       // Extract the actual data from response['data']
//       final data = response['data'];
//       if (data != null) {
//         return UserProfileModel.fromJson(data);
//       }
//     }

//     throw ApiError;
//   }
// }

// class ProductOwnerProfileRepo {
//   final ApiService _apiService = ApiService();

//   Future<List<ProductModel>> getProductsOfUser(String userId) async {
//     final response = await _apiService.get(
//       '/api/Products/GetProductsOfSpecificUser',
//       {'userId': userId},
//     );

//     if (response is ApiError) {
//       throw response;
//     }

//     if (response is List) {
//       return response
//           .map((e) => ProductModel.fromJson(e))
//           .toList();
//     }

//     throw ApiError(message: 'Unexpected response');
//   }
// }
import 'package:dio/dio.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/feauture/product_screens/data/model/prodect_model_explore.dart';
import 'package:graduation2/feauture/profile/data/user_account_model.dart';
import 'package:graduation2/feauture/profile/data/user_profile_model.dart';
import 'package:graduation2/feauture/product_screens/data/model/creatprodect_model.dart';

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
      //   return response.data;
      // } on DioException catch (e) {
      //   return ApiExceptions.handleError(e);
      // }
      return _handleResponse(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  /// POST
  Future<dynamic> post(String endPoint, dynamic body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      // return response.data;
      // } on DioException catch (e) {
      //   return ApiExceptions.handleError(e);
      // }
      return _handleResponse(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  //// path
  Future<dynamic> patch(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.patch(endPoint, data: body);
      // return response.data;
      // } on DioException catch (e) {
      //   return ApiExceptions.handleError(e);
      // }
      return _handleResponse(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  /// PUT // UPDATE
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      //   return response.data;
      // } on DioException catch (e) {
      //   return ApiExceptions.handleError(e);
      // }
      return _handleResponse(response.data);
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }

  // dynamic _handleResponse(dynamic data) {
  //   if (data is Map<String, dynamic> && data['success'] == false) {
  //     throw ApiError(
  //       message: data['message'] ?? 'Something went wrong',
  //       statusCode: data['statusCode'],
  //     );
  //   }
  //   return data;
  // }
  dynamic _handleResponse(dynamic data) {
    if (data is Map<String, dynamic> && data['success'] == false) {
      throw ApiError(
        message: data['message'] ?? 'Something went wrong',
        statusCode: data['statusCode'] is int
            ? data['statusCode']
            : int.tryParse(data['statusCode']?.toString() ?? ''),
      );
    }
    return data;
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

class UserProfileRepo {
  final ApiService _apiService = ApiService();

  Future<UserProfileModel> getCurrentUser() async {
    final response = await _apiService.get('/api/UserProfile', null);

    if (response is ApiError) {
      throw response;
    }

    // ⚠️ FIX: Handle the nested "data" structure properly
    if (response is Map<String, dynamic>) {
      // Check if response has success = false
      if (response['success'] == false) {
        final errorMsg =
            response['errors']?['errorMessage'] ??
            response['message'] ??
            'Failed to fetch profile';
        throw ApiError;
      }

      // Extract the actual data from response['data']
      final data = response['data'];
      if (data != null) {
        return UserProfileModel.fromJson(data);
      }
    }

    throw ApiError;
  }

  Future<UserAccountModel> getAccountById(String userId) async {
    final response = await _apiService.get('/api/Accounts/GetAccount', {
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

class ProductOwnerProfileRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductsModel>> getProductsOfUser(String userId) async {
    final response = await _apiService.get(
      '/api/Products/GetProductsOfSpecificUser',
      {'userId': userId},
    );

    if (response is ApiError) {
      throw response;
    }

    if (response is List) {
      return response.map((e) => ProductsModel.fromJson(e)).toList();
    }

    throw ApiError(message: 'Unexpected response');
  }

  Future<List<ProductsModel>> getRawMatrialOfUser(String userId) async {
    final DioClient _dioClient = DioClient();
    try {
      final response = await _dioClient.dio.post(
        '/api/RawMaterial/GetRawMaterialOfSpecificUser',
        queryParameters: {"userId": userId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    }
  }
  //

  //  try {
  //     final response = await _dioClient.dio.get(
  //       '/api/Reviews/GetUserStats',
  //       queryParameters: {'targetUserId': productId},
  //     );

  //     if (response.statusCode == 200 && response.data != null) {
  //       return UserStateModel.fromJson(response.data['data']);
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     throw ApiExceptions.handleError(e);
  //   }
  // if (response is ApiError) {
  //   throw response;
  // }

  // if (response is List) {
  //   return response.map((e) => ProductsModel.fromJson(e)).toList();
  // }

  //throw ApiError(message: 'Unexpected response');
}
  class CartRepo {
  final ApiService _apiService = ApiService();

  Future<void> addItemToCart({
    required String cartId,
    required int itemId,
  }) async {

    final response = await _apiService.post(
      '/api/Carts/AddItem?cartId=$cartId&itemId=$itemId',
      null,
    );

    if (response is ApiError) {
      throw response;
    }
  }
}
