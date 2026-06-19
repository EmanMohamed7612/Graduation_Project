/*import 'package:dio/dio.dart';

import '../../../../core/const/api_endpoint.dart';
import '../../../../core/services/dio_client.dart';
import '../data/model/deliver_addressmodel.dart';


class AddressApiService {
  final DioClient _dioClient;

  AddressApiService(this._dioClient);

  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.GetUserAddress);

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => AddressModel.fromJson(item)).toList();
      } else {
        throw Exception("Failed to load addresses");
      }
    } catch (e) {
      rethrow;
    }
  }
}*/
import 'package:dio/dio.dart';
import '../../../../core/const/api_endpoint.dart';
import '../../../../core/services/dio_client.dart';
import '../data/model/deliver_addressmodel.dart';

class AddressApiService {
  final DioClient _dioClient;

  AddressApiService(this._dioClient);

  //Future<List<AddressModel>> getUserAddresses() async {
   // try {
     // final response = await _dioClient.dio.get(ApiEndpoint.GetUserAddress);

      //if (response.statusCode == 200) {
        // الوصول للقائمة داخل حقل data لأن الـ API يعيد Map وليس List مباشرة
        //final dynamic responseData = response.data;

        //if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {
          //List<dynamic> data = responseData['data'];
         // return data.map((item) => AddressModel.fromJson(item)).toList();
        //} else if (responseData is List) {
          // في حال كان الرد قائمة مباشرة (احتياطاً)
        //  return responseData.map((item) => AddressModel.fromJson(item)).toList();
      //  } else {
          //throw Exception("Unexpected data format");
       // }
    //  } else {
        //throw Exception("Failed to load addresses with status: ${response.statusCode}");
     // }
   // } catch (e) {
     // rethrow;
  //  }
 // }
  Future<List<AddressModel>> getUserAddresses() async {
    try {
      final response = await _dioClient.dio.get(ApiEndpoint.GetUserAddress);

      // 👇 أول print (مهم جدًا)
      print("🔥 FULL RESPONSE: ${response.data}");

      if (response.statusCode == 200) {

        final dynamic responseData = response.data;

        // 👇 تاني print
        print("🔥 responseData TYPE: ${responseData.runtimeType}");

        if (responseData is Map<String, dynamic> && responseData.containsKey('data')) {

          List<dynamic> data = responseData['data'];

          // 👇 تالت print
          print("🔥 DATA LIST: $data");

          return data.map((item) => AddressModel.fromJson(item)).toList();

        } else if (responseData is List) {

          // 👇 لو جاي List مباشر
          print("🔥 LIST DIRECT: $responseData");

          return responseData.map((item) => AddressModel.fromJson(item)).toList();

        } else {
          throw Exception("Unexpected data format");
        }

      } else {
        throw Exception("Failed with status: ${response.statusCode}");
      }

    } catch (e) {
      print("❌ API ERROR: $e"); // 👈 مهم جدًا
      rethrow;
    }
  }
}