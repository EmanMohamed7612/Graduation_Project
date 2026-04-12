

import '../data/model/search_category_model.dart';

abstract class SearchcategoryState {}

class SearchcategoryInitial extends SearchcategoryState {}
class SearchcategoryLoading extends SearchcategoryState {}
class SearchcategorySuccess extends SearchcategoryState {
  final List<SearchcategoryModel> products;
  SearchcategorySuccess(this.products);
}
class SearchcategoryFailure extends SearchcategoryState {
  final String errMessage;
  SearchcategoryFailure(this.errMessage);
}