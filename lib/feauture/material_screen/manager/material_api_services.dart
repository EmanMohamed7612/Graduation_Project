import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../core/const/api_endpoint.dart';
import '../../../core/services/api_error.dart';
import '../../../core/services/api_exceptions.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/dio_client.dart';
import '../../../core/utils/pref_helpers.dart';


import '../../home/data/model/categories_model_forhome.dart';
import '../data/model/addmaterialmodel.dart';
import '../data/model/materialmodel.dart';
import '../data/model/update_material.dart';

class MaterialApiService {
  final DioClient _dioClient = DioClient();

  // 1️⃣ Create Product
  Future<CreatematerialResponseModel> creatematerial(CreatematerialRequestModel model) async {
    final formData = FormData.fromMap({
      'NameEn': model.nameEn,
      'NameAr': model.nameAr,
      'Price': model.price,
      'Quantity': model.quantity,
      'Description': model.description,
      'CategoryId': model.categoryId,
      'ImageFile': await MultipartFile.fromFile(
        model.imageFile,
        filename: model.imageFile.split('/').last,
      ),
      'Tgs': model.tags,
    });

    Response response = await _dioClient.dio.post(
      ApiEndpoint.CreateRawMaterial,
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CreatematerialResponseModel.fromJson(response.data);
    } else {
      throw ApiExceptions.handleError(response.data);
    }
  }
  ///---------------------
  // // 2️⃣ Update Product
  Future<CreatematerialResponseModel> updatematerial(UpdatematerialRequestModel model) async {
    try {
      final token = await PrefHelpers.getToken();
      String sellerName = model.sellerName ?? '';

      if (sellerName.isEmpty && token != null) {
        final parts = token.split('.');
        final payload = json.decode(
          utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
        );
        sellerName = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'] ?? '';
      }

      final map = <String, dynamic>{
        'NameEn': model.nameEn,
        'NameAr': model.nameAr,
        'Price': model.price,
        'Quantity': model.quantity,
        'Description': model.description,
        'CategoryId': model.categoryId,
        'Tgs': model.tags,
        'SellerName': sellerName,
      };
      print('🔍 map keys: ${map.keys.toList()}');
      if (model.imageFile != null) {
        map['ImageFile'] = await MultipartFile.fromFile(
          model.imageFile!,
          filename: model.imageFile!.split('/').last,
        );
      }

      Response response = await _dioClient.dio.put(
        ApiEndpoint.UpdateRowMaterial,
        queryParameters: {'id': model.id},
        data: FormData.fromMap(map),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return CreatematerialResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      rethrow;
    }
  }



  // 4️⃣ Get Categories
  Future<List<CategoriesModel>> fetchrawmaterialCategories() async {
    final response = await _dioClient.dio.get(ApiEndpoint.GetAllRawMaterialCategories);

    if (response.data is Map) {
      // ✅ جرب الاتنين capital و small
      final list = response.data['Data'] ?? response.data['data'];
      if (list != null) {
        return (list as List)
            .map((e) => CategoriesModel.fromJson(e))
            .toList();
      }
    }

    if (response.data is List) {
      return (response.data as List)
          .map((e) => CategoriesModel.fromJson(e))
          .toList();
    }

    return [];
  }
  Future<void> deletematerial(int id) async {
    final response = await _dioClient.dio.delete(
      ApiEndpoint.DeleteRowMaterial,
      queryParameters: {'id': id},
    );
  }


}




