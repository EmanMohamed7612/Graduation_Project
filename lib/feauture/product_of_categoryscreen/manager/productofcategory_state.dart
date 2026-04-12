// States
import 'package:flutter_bloc/flutter_bloc.dart';


import '../data/model/productofcategory_model.dart';

abstract class CategoryProductState {}
class CategoryProductInitial extends CategoryProductState {}
class CategoryProductLoading extends CategoryProductState {}
class CategoryProductSuccess extends CategoryProductState {
  final List<CategoryofProductModel> products;
  CategoryProductSuccess(this.products);
}
class CategoryProductError extends CategoryProductState {
  final String message;
  CategoryProductError(this.message);
}

// Cubit
