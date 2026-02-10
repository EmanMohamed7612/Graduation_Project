import 'package:flutter_bloc/flutter_bloc.dart';


import '../../product_screens/manager/prodect_apiservice.dart';
import 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final ProductApiService apiService;

  CategoryCubit(this.apiService) : super(CategoryInitial());

  void fetchCategories() async {
    emit(CategoryLoading());
    try {
      final data = await apiService.fetchCategories();
      emit(CategorySuccess(data));
    } catch (e) {
      emit(CategoryFailure(e.toString()));
    }
  }
}

