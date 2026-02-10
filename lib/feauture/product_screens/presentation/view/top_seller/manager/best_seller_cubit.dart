import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../manager/prodect_apiservice.dart';
import 'best)seller_state.dart';


class BestSellerCubit extends Cubit<BestSellerState> {
  final ProductApiService apiService;

  BestSellerCubit(this.apiService) : super(BestSellerInitial());

  Future<void> fetchBestSeller() async {
    emit(BestSellerLoading());
    try {
      final products = await apiService.getBestSellerProducts();
      emit(BestSellerSuccess(products));
    } catch (e) {
      emit(BestSellerFailure(e.toString()));
    }
  }
}
