/*import 'package:flutter_bloc/flutter_bloc.dart';

import 'getuseraddress_apiserves.dart';
import 'getuseraddress_state.dart';


class AddressCubit extends Cubit<AddressState> {
  final AddressApiService _apiService;

  AddressCubit(this._apiService) : super(AddressInitial());

  Future<void> fetchAddresses() async {
    emit(AddressLoading());
    try {
      final addresses = await _apiService.getUserAddresses();
      emit(AddressSuccess(addresses));
    }catch (e) {
      print("ERROR: $e"); // 🔥 مهم جدًا
      emit(AddressError(e.toString()));
    }
  }
}*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'getuseraddress_apiserves.dart';
import 'getuseraddress_state.dart';

class AddressCubit extends Cubit<AddressState> {
  final AddressApiService _apiService;


  AddressCubit(this._apiService) : super(AddressInitial());


  Future<void> fetchAddresses() async {
    emit(AddressLoading());
    try {
      final addresses = await _apiService.getUserAddresses();
      print("✅ ADDRESSES LENGTH: ${addresses.length}");
      print("✅ ADDRESSES: $addresses");
      if (addresses.isEmpty) {
        emit(AddressError("No addresses found"));

      } else {
        emit(AddressSuccess(addresses)

        );

      }
    } catch (e) {
      // طباعة الخطأ في الـ Console للمساعدة في التتبع
      print("AddressCubit Error: $e");
      emit(AddressError("حدث خطأ أثناء تحميل العناوين: ${e.toString()}"));
    }
  }
}