import 'package:dio/dio.dart';
import '../../../../core/services/dio_client.dart';
import '../data/add_address_model.dart';


class AddAddressApiService {
  final DioClient _dioClient;
  AddAddressApiService(this._dioClient);

  Future<void> addAddress(AddAddressModel address) async {
    try {
      await _dioClient.dio.post(
        '/api/Orders/AddAddress',
        data: address.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}