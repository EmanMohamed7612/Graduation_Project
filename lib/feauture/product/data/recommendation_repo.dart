import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/product/data/product_recommend_model.dart';

class RecommendationRepo {
  final ApiService _apiService = ApiService();

  Future<List<ProductRecommendModel>> getRecommendations(int productId) async {
    final response = await _apiService.get(
      '/api/Recommendations/collaborative/$productId',
      null,
    );

    if (response is Map<String, dynamic>) {
      final List<dynamic> data = response['data'] ?? [];
      return data.map((e) => ProductRecommendModel.fromJson(e)).toList();
    }

    throw Exception("Failed to load recommendations");
  }
}