import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/add_address_model.dart';
import 'add_address_apiservces.dart';
import 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  final AddAddressApiService _apiService;
  AddAddressCubit(this._apiService) : super(AddAddressInitial());

  Future<void> addNewAddress(AddAddressModel address) async {
    emit(AddAddressLoading());
    try {
      await _apiService.addAddress(address);
      emit(AddAddressSuccess());
    } catch (e) {
      emit(AddAddressError("فشل في إضافة العنوان، حاول مرة أخرى"));
    }
  }
}