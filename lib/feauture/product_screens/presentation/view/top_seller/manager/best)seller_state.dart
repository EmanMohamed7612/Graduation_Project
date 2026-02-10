import '../../../../data/model/prodect_model_explore.dart';

sealed class BestSellerState {}

final class BestSellerInitial extends BestSellerState {}

final class BestSellerLoading extends BestSellerState {}

final class BestSellerSuccess extends BestSellerState {
  final List<ProductsModel> products;
  BestSellerSuccess(this.products);
}

final class BestSellerFailure extends BestSellerState {
  final String errorMessage;
  BestSellerFailure(this.errorMessage);
}
