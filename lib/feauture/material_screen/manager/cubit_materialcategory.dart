import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/material_screen/manager/state_materialcategory.dart';


import '../../product_screens/manager/prodect_apiservice.dart';
import 'material_api_services.dart';

class CategorymaterialCubit extends Cubit<CategorymaterialState> {
  final MaterialApiService apiService;

  CategorymaterialCubit(this.apiService) : super(CategorymaterialInitial());

  void fetchmaterialCategories() async {
    emit(CategorymaterialLoading());
    try {
      final data = await apiService.fetchrawmaterialCategories();
      print('Categories: ${data.length}');
      emit(CategorymaterialSuccess(data));
    } catch (e) {
      print(' Error: $e');
      emit(CategorymaterialFailure(e.toString()));
    }
  }
}

