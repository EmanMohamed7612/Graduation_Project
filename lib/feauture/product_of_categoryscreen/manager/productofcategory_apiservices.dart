/*import 'package:dio/dio.dart';

import '../data/model/productofcategory_model.dart';

class CategoryProductService {
  final Dio _dio;
  CategoryProductService(this._dio);

  Future<List<CategoryofProductModel>> getProductsByCategory(int id) async {
    try {
      final response = await _dio.get(
        'https://craftoriagp.runasp.net/api/Products/GetAllProductsOfSpecificCategory',
        queryParameters: {'id': id},
      );

      List<dynamic> data = response.data['data'];
      return data.map((item) => CategoryofProductModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}*/
import 'package:dio/dio.dart';

import '../data/model/productofcategory_model.dart';

class CategoryProductService {
  final Dio _dio;
  CategoryProductService(this._dio);

  Future<List<CategoryofProductModel>> getProductsByCategory(int id) async {
    try {
      final response = await _dio.get(
        'https://craftoriagp.runasp.net/api/Products/GetAllProductsOfSpecificCategory',
        queryParameters: {'id': id},
      );
      final success = response.data['success'] ?? response.data['Success'];
      final rawData = response.data['data'] ?? response.data['Data'];

      // ✅ تأكدي من فحص حالة النجاح من داخل الـ JSON
      if (response.data['success'] == true) {
        List<dynamic> data = response.data['data'];
        return data.map((item) => CategoryofProductModel.fromJson(item)).toList();
      } else {
        // لو السيرفر بعت success: false
        throw Exception(response.data['message'] ?? 'Unknown Error from Server');
      }
    } on DioException catch (e) {
      // ✅ طباعة تفاصيل الخطأ لو المشكلة في الاتصال أو الـ URL
      print("Dio Error: ${e.response?.data}");
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      // ✅ طباعة لو المشكلة في الـ Parsing (الموديل مش عارف يقرا الداتا)
      print("Parsing Error: $e");
      throw Exception('Data Parsing Error');
    }
  }
}