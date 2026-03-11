

import '../../home/data/model/categories_model_forhome.dart';

abstract class CategorymaterialState {}

class CategorymaterialInitial extends CategorymaterialState {}

class CategorymaterialLoading extends CategorymaterialState {}

class CategorymaterialSuccess extends CategorymaterialState {
  final List<CategoriesModel> categories;
  CategorymaterialSuccess(this.categories);
}

class CategorymaterialFailure extends CategorymaterialState {
  final String error;
  CategorymaterialFailure(this.error);
}
