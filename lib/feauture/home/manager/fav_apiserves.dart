import 'package:graduation2/feauture/favourite/data/favourite_model.dart';

import '../../../core/services/dio_client.dart';

class FavoriteApiService {
  final DioClient _dioClient;

  FavoriteApiService(this._dioClient);

  Future<void> toggleFavorite(int productId) async {
    try {
      // الـ Endpoint بتاخد الـ productId كـ Query Parameter
      await _dioClient.dio.post(
        '/api/Favourites/Toggle',
        queryParameters: {'productId': productId},
      );
    } catch (e) {
      rethrow; // عشان الـ Cubit يعرف إن فيه مشكلة حصلت
    }
  }

  Future<List<FavouriteModel>> getMyFavourites() async {
    final response = await _dioClient.dio.get('/api/Favourites/MyFavourites');

    //final List data = response.data;
    // final data = response.data['data'];
    final List data = response.data['data'] ?? [];

    return data.map((e) => FavouriteModel.fromJson(e)).toList();
  }

  Future<void> removeFavorite(int productId) async {
    await _dioClient.dio.post(
      '/api/Favourites/Toggle',
      queryParameters: {'productId': productId},
    );
  }
}
