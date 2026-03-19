import 'package:dio/dio.dart';

import '../../../core/services/api_error.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/utils/pref_helpers.dart';
import '../data/model/materialsupplierdashboard.dart';
import '../data/model/productsellerdashboardmodel.dart';

class MaterialsupplierdashboardApiService {
  final Dio _dio = DioClient().dio; // استخدام الـ DioClient الخاص بك

  Future<List<materialsupplierdashboardModel>> getspacificsupplierProducts() async {
    final userId = await PrefHelpers.getUserId(); // ✅ userId مش token
    if (userId == null || userId.isEmpty) {
      throw ApiError(message: 'User not authenticated');
    }

    final response = await _dio.post(
      "/api/RawMaterial/GetRawMaterialOfSpecificUser",
      queryParameters: {'userId': userId},
    );

    if (response.data is List) {
      return (response.data as List)
          .map((e) => materialsupplierdashboardModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Invalid data format");
    }
  }}