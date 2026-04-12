import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product_of_categoryscreen/manager/productofcategory_apiservices.dart';
import 'package:graduation2/feauture/product_of_categoryscreen/manager/productofcategory_state.dart';

class CategoryProductCubit extends Cubit<CategoryProductState> {
  final CategoryProductService api;
  CategoryProductCubit(this.api) : super(CategoryProductInitial());

  void fetchProducts(int categoryId) async {
    emit(CategoryProductLoading());
    try {
      final products = await api.getProductsByCategory(categoryId);
      emit(CategoryProductSuccess(products));
    } catch (e) {
      print("DEBUG ERROR: $e");
      emit(CategoryProductError(e.toString()));
    }
  }
}