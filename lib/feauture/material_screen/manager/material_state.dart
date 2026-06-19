import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/api_services.dart';
import '../../../../core/const/api_endpoint.dart';
import '../data/model/addmaterialmodel.dart';
import '../data/model/materialmodel.dart';


sealed class materialState {}
final class materialInitial extends materialState {}
final class materialLoading extends materialState {}
final class materialSuccess extends materialState {
  final List<materialModel> products;
  materialSuccess(this.products);
}
final class materialFailure extends materialState {
  final String errorMessage;
  materialFailure(this.errorMessage);

}


/// CreateProducts State

abstract class CreatematerialState {}

class CreatesupplierInitialState  extends CreatematerialState {}

class CreatesupplierLoadingState  extends CreatematerialState {}

class CreatesupplierSuccessState  extends CreatematerialState {
  final CreatematerialResponseModel product;

  CreatesupplierSuccessState({required this.product});
}

class CreatesupplierErrorState  extends CreatematerialState {
  final String message;

  CreatesupplierErrorState({required this.message});

}

/// UpdateProduct State

abstract class UpdatematerialState {}

class UpdatesupplierInitialState extends UpdatematerialState {}

class UpdatesupplierLoadingState extends UpdatematerialState {}

class UpdatesupplierSuccessState extends UpdatematerialState {
  final CreatematerialResponseModel product;

  UpdatesupplierSuccessState({required this.product});
}

class UpdatesupplierErrorState extends UpdatematerialState {
  final String message;

  UpdatesupplierErrorState({required this.message});
}


// Delete Product State
abstract class DeletematerialState {}

class DeletesupplierInitialState extends DeletematerialState {}

class DeletesupplierLoadingState extends DeletematerialState {}

class DeletesupplierSuccessState extends DeletematerialState {}

class DeletesupplierErrorState extends DeletematerialState {
  final String message;
  DeletesupplierErrorState({required this.message});
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
