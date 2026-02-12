import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/core/services/api_services.dart';
import 'package:graduation2/feauture/product_screens/manager/product_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductOwnerProfileRepo repo;

  ProductsCubit(this.repo) : super(ProductsInitial());

  Future<void> getProducts(String userId) async {
    emit(ProductsLoading());
    try {
      final products = await repo.getProductsOfUser(userId);
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
