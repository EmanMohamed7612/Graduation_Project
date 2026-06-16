import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation2/feauture/home/manager/search_apiservice.dart';
import 'package:graduation2/feauture/home/manager/search_state.dart';
import 'package:graduation2/feauture/product_of_categoryscreen/manager/search_category_api_services.dart';
import 'package:graduation2/feauture/product_of_categoryscreen/manager/search_category_state.dart';

class SearchcategoryCubit extends Cubit<SearchcategoryState> {
  final SearchcategoryApiService searchcategoryApiService;
  SearchcategoryCubit(this.searchcategoryApiService) : super(SearchcategoryInitial());

  Future<void> fetchSearchcategoryResults(String query) async {
    if (query.isEmpty) {
      emit(SearchcategoryInitial());
      return;
    }

    emit(SearchcategoryLoading());
    try {
      final results = await searchcategoryApiService.searchcategory(query);
      emit(SearchcategorySuccess(results));
    } catch (e) {
      emit(SearchcategoryFailure(e.toString()));
    }
  }
}