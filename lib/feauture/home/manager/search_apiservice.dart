import 'package:dio/dio.dart';

import '../data/search_model.dart';

class SearchApiService {
  final Dio _dio;
  SearchApiService(this._dio);

  Future<List<SearchProductModel>> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        'https://craftoriagp.runasp.net/api/Home/Search',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => SearchProductModel.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load results');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}