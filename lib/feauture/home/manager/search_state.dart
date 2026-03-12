import '../data/search_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchLoading extends SearchState {}
class SearchSuccess extends SearchState {
  final List<SearchProductModel> products;
  SearchSuccess(this.products);
}
class SearchFailure extends SearchState {
  final String errMessage;
  SearchFailure(this.errMessage);
}