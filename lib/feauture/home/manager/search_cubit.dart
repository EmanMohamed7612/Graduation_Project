import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/home/manager/search_apiservice.dart';
import 'package:graduation2/feauture/home/manager/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchApiService searchApiService;
  SearchCubit(this.searchApiService) : super(SearchInitial());

  Future<void> fetchSearchResults(String query) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      final results = await searchApiService.searchProducts(query);
      emit(SearchSuccess(results));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }
}