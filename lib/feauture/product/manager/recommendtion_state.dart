import 'package:graduation2/feauture/product/data/product_recommend_model.dart';

abstract class RecommendationState {}

class RecommendationInitial extends RecommendationState {}
class RecommendationLoading extends RecommendationState {}
class RecommendationSuccess extends RecommendationState {
  final List<ProductRecommendModel> products;
  RecommendationSuccess(this.products);
}
class RecommendationFailure extends RecommendationState {
  final String errorMessage;
  RecommendationFailure(this.errorMessage);
}