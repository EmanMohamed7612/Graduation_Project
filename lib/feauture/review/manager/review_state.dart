import 'package:graduation2/feauture/review/data/product_review_model.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewLoaded extends ReviewState {
  final List<ProductReviewModel> reviews;

  ReviewLoaded(this.reviews);
}

class ReviewError extends ReviewState {
  final String message;

  ReviewError(this.message);
}