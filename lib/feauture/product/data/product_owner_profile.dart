import 'package:dio/dio.dart';
import 'package:graduation2/core/const/api_endpoint.dart';
import 'package:graduation2/core/services/api_error.dart';
import 'package:graduation2/core/services/api_exceptions.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/product_screens/data/model/prodect_model_explore.dart';

class ProductOwnerProfileRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductsModel>> getProductsOfUser(String userId) async {
    final response = await _apiService.get(
      ApiEndpoint.getProductOfSpecificUser,
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
       ApiEndpoint.getRawMaterialOfSpecificUser,
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

}