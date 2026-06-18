import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/product/data/recommendation_repo.dart';
import 'package:graduation2/feauture/product/manager/recommendtion_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  final RecommendationRepo recommendationRepo;

  RecommendationCubit(this.recommendationRepo) : super(RecommendationInitial());

  Future<void> fetchRecommendations(int productId) async {
    emit(RecommendationLoading());
    try {
      final products = await recommendationRepo.getRecommendations(productId);
      emit(RecommendationSuccess(products));
    } catch (e) {
      emit(RecommendationFailure(e.toString()));
    }
  }
}