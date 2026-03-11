import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/core/services/dio_client.dart';
import 'package:graduation2/feauture/review/data/cart_model.dart';

class CartRepo {
  final ApiService _apiService = ApiService();
  final DioClient _dioClient = DioClient();

  /// 1️⃣ Get Cart
  Future<CartDto> getCart(String cartId) async {
    final response = await _apiService.get('/api/Carts/GetCartUser', {
      'id': cartId,
    });

    final data = response['data'];

    return CartDto.fromJson(data);
  }

  /// 2️⃣ Add Item
  Future<CartDto> addItem({required String cartId, required int itemId}) async {
    final response = await _dioClient.dio.post(
      '/api/Carts/AddItem',
      queryParameters: {"cartId": cartId, "itemId": itemId},
    );

    final data = response.data['data']; // 👈 مهم جداً

    return CartDto.fromJson(data);
    // return CartDto.fromJson(response.data);
  }

  /// 3️⃣ Update Quantity
  Future<CartDto> updateQuantity({
    required String cartId,
    required int productId,
    required bool isIncrement,
  }) async {
    final response = await _dioClient.dio.patch('/api/Carts/Quantity', 
    queryParameters: {
      "cartId": cartId,
      "productId": productId,
      "isIncrement": isIncrement,
    });

      final data = response.data['data']; // 👈 مهم جداً

    return CartDto.fromJson(data);
  }

  /// 4️⃣ Remove Item
  Future<CartDto?> deleteItem({
    required String cartId,
    required int itemId,
  }) async {
    final response = await _apiService.delete(
      '/api/Carts/DeleteItem',
      queryParameters: {"cartId": cartId, "ItemId": itemId},
    );

    if (response['data'] == null) return null;

    return CartDto.fromJson(response['data']);
  }
}
