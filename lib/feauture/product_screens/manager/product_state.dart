import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/const/api_endpoint.dart';
import '../data/model/creatprodect_model.dart';

import '../data/model/prodect_model_explore.dart';


sealed class ProductState {}
final class ProductInitial extends ProductState {}
final class ProductLoading extends ProductState {}
final class ProductSuccess extends ProductState {
  final List<ProductsModel> products;
  ProductSuccess(this.products);
}
final class ProductFailure extends ProductState {
  final String errorMessage;
  ProductFailure(this.errorMessage);

}



// abstract class ProductsState {}

// class ProductsInitial extends ProductsState {}

// class ProductsLoading extends ProductsState {}

// class ProductsSuccess extends ProductsState {
//   final List<ProductsModel> products;
//   ProductsSuccess(this.products);
// }

// class ProductsError extends ProductsState {
//   final String message;
//   ProductsError(this.message);
// }
