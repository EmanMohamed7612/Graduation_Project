import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'fav_apiserves.dart';

class FavoriteCubit extends Cubit<List<int>> {
  final FavoriteApiService _apiService;

  FavoriteCubit(this._apiService) : super([]);

  // وظيفة للتأكد إذا كان المنتج في المفضلة أم لا
  bool isFavorite(int productId) => state.contains(productId);

  Future<void> toggleFavorite(int productId) async {
    final currentFavorites = List<int>.from(state);

    // 1. تحديث الـ UI "لحظياً" قبل انتظار الـ API (Optimistic Update)
    if (currentFavorites.contains(productId)) {
      currentFavorites.remove(productId);
    } else {
      currentFavorites.add(productId);
    }
    emit(currentFavorites); // هنا الـ Counter والقلب هيتحدثوا فوراً

    // 2. إرسال الطلب للسيرفر
    try {
      await _apiService.toggleFavorite(productId);
    } catch (e) {
      // إذا فشل الـ API، سنقوم ببساطة بـ emit للحالة السابقة (state)
      // لأننا لم نقم بتعديل الـ state الأصلية فعلياً بل كنا نعدل نسخة منها
      emit(List<int>.from(state));

      log("حدث خطأ أثناء تحديث المفضلة: $e");
    }
  }
}