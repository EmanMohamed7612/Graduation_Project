
/*import 'package:dio/dio.dart';
=======
import 'package:dio/dio.dart';
>>>>>>> origin/book-session
import '../../../../core/services/dio_client.dart';

class CartApiService {
  // بنستخدم النسخة اللي فيها interceptors عشان التوكن يتبعت تلقائي
  final Dio _dio = DioClient().dio;

  Future<void> addItemToCart({
    required String cartId,
    required int itemId,
  }) async {
    try {
      await _dio.post(
        "/api/Carts/AddItem",
        // جربي تبعتيهم كـ data (Body) لو الـ API مش شغال queryParameters
        queryParameters: {
          "cartId": cartId,
          "itemId": itemId,
        },
      );
    } on DioException catch (e) {
      // هنا بنستخدم الـ ApiExceptions اللي إنتِ بعتيه عشان نفهم الغلط فين
      throw e;
    }
  }
<<<<<<< HEAD
}*/



