import 'package:dio/dio.dart';

import '../data/model/search_category_model.dart';


class SearchcategoryApiService {
  final Dio _dio;
  SearchcategoryApiService(this._dio);

  Future<List<SearchcategoryModel>> searchcategory(String query) async {
    try {
      final response = await _dio.get(
        'https://craftoriagp.runasp.net/api/Products/SearchForProductsInCategory',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => SearchcategoryModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}