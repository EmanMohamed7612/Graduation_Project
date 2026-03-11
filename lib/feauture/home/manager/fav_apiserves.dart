/*import '../../../core/services/dio_client.dart';

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
}*/

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


}
