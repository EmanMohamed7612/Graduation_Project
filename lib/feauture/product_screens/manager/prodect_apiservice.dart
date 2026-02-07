import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'dart:developer';
import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/utils/pref_helpers.dart';
import '../data/model/creatprodect_model.dart';

class ProductApiService {
  final DioClient _dioClient = DioClient();
 final ApiService _apiService = ApiService();
  // 1️⃣ Create Product
  Future<ProductModel?> createProduct(ProductModel product) async {
    try {
      log('📤 Creating product: ${product.name}');

      final token = await PrefHelpers.getToken();
      if (token == null || token.isEmpty) {
        throw ApiError(message: 'User not authenticated');
      }

      final sellerId = _getUserIdFromToken(token);

      // ✅ تم إزالة المسافات الزائدة من الأسماء (Name, Price, CategoryId)
      FormData formData = FormData.fromMap({
        'Name': product.name,
        'Price': product.price,
        'Quantity': product.stock,
        'CategoryId': product.category,
        'Description': product.description,
        'SellerId': sellerId,
      });

      if (product.imagePath != null && product.imagePath!.isNotEmpty) {
        String fileName = product.imagePath!.split('/').last;
        formData.files.add(
          MapEntry(
            'ImageFile',
            await MultipartFile.fromFile(
              product.imagePath!,
              filename: fileName,
            ),
          ),
        );
      }

      final response = await _dioClient.dio.post(
        ApiEndpoint.createProduct,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log('✅ Product created successfully');
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('data') && responseData['data'] != null) {
            return ProductModel.fromJson(responseData['data']);
          }
          return ProductModel.fromJson(responseData);
        }
        return null;
      } else {
        log('❌ Failed to create product: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      log('❌ DioException in createProduct: ${e.response?.data ?? e.message}');
      throw ApiExceptions.handleError(e);
    } catch (e) {
      log('❌ Exception in createProduct: $e');
      rethrow;
    }
  }

  // 2️⃣ Update Product
  Future<bool> updateProduct(ProductModel product) async {
    try {
      log('🔄 Updating product: ${product.name} (ID: ${product.id})');

      final token = await PrefHelpers.getToken();
      if (token == null) return false;

      final sellerId = _getUserIdFromToken(token);

      // ✅ تأكدي أن 'Id' حرف كبير كما يطلبه السيرفر في الـ Create
      FormData formData = FormData.fromMap({
        'id': product.id,
        'Name': product.name,
        'Price': product.price,
        'Quantity': product.stock,
        'CategoryId': product.category,
        'Description': product.description,
        'SellerId': sellerId,
      });

      // إضافة الصورة فقط إذا كانت مساراً محلياً (ليست رابط http)
      if (product.imagePath != null &&
          product.imagePath!.isNotEmpty &&
          !product.imagePath!.startsWith('http')) {
        String fileName = product.imagePath!.split('/').last;
        formData.files.add(MapEntry(
          'ImageFile',
          await MultipartFile.fromFile(product.imagePath!, filename: fileName),
        ));
      }

      final response = await _dioClient.dio.put(
        "${ApiEndpoint.updateProduct}?id=${product.id}", // إضافة ?id=
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      log('✅ Update Response: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      if (e is DioException) {
        log('❌ Update Error Details: ${e.response?.data}');
      }
      log('❌ Update Error: $e');
      return false;
    }
  }

  // 3️⃣ Helper to decode Token
  String _getUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return '';
      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      return payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'].toString();
    } catch (e) {
      log('❌ Error decoding token: $e');
      return '';
    }
  }
 /// Get number of products for the current user 
Future<int> getMyProductsCount() async {
  final token = await PrefHelpers.getToken();
  if (token == null || token.isEmpty) {
    throw ApiError(message: 'User not authenticated');
  }

  final response = await _dioClient.dio.get(
    '/api/Products/my-products-count',
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
    return response.data['totalProducts'] ?? 0;
  }

  throw ApiError(message: 'Failed to load product count');
}

}