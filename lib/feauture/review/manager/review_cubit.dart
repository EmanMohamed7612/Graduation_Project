import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/review/data/product_review_model.dart';
import 'package:graduation2/feauture/review/data/review_service.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewApiService reviewApiService;

  ReviewCubit(this.reviewApiService) : super(ReviewInitial());

  Future<void> getUserReviews(String userId) async {
    emit(ReviewLoading());

    try {
      final reviews = await reviewApiService.getUserReviews(userId);

      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> getProductReviews(int productId) async {
    emit(ReviewLoading());

    try {
      final reviews = await reviewApiService.getProductReviews(productId);

      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }

  Future<void> getCreatedReviews(String userId) async {
    emit(ReviewLoading());

    try {
      final reviews = await reviewApiService.getCreatedReviews(userId);

      emit(ReviewLoaded(reviews));
    } catch (e) {
      emit(ReviewError(e.toString()));
    }
  }
}
