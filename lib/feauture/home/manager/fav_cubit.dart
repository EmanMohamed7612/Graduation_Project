/*import 'package:flutter_bloc/flutter_bloc.dart';
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
}*/
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart'; // تأكدي من إضافة المكتبة في pubspec.yaml
import 'fav_apiserves.dart';

class FavoriteCubit extends Cubit<List<int>> {
  final FavoriteApiService _apiService;
  static const String _favKey = 'favorite_ids'; // مفتاح الحفظ

  FavoriteCubit(this._apiService) : super([]) {
    loadFavorites(); // تحميل البيانات بمجرد إنشاء الكيوبيت
  }

  // وظيفة للتأكد إذا كان المنتج في المفضلة أم لا
  bool isFavorite(int productId) => state.contains(productId);

  // --- 1. تحميل المفضلة من الجهاز ---
  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedFavs = prefs.getStringList(_favKey);

    if (savedFavs != null) {
      // تحويل الـ Strings المحفوظة مرة أخرى إلى Integers
      final List<int> ids = savedFavs.map((e) => int.parse(e)).toList();
      emit(ids);
    }
  }

  // --- 2. حفظ المفضلة في الجهاز ---
  Future<void> _saveToPrefs(List<int> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    // تحويل الأرقام إلى نصوص لأن SharedPreferences تحفظ قائمة نصوص فقط
    final List<String> stringList = favorites.map((e) => e.toString()).toList();
    await prefs.setStringList(_favKey, stringList);
  }

  Future<void> toggleFavorite(int productId) async {
    final currentFavorites = List<int>.from(state);

    if (currentFavorites.contains(productId)) {
      currentFavorites.remove(productId);
    } else {
      currentFavorites.add(productId);
    }
    emit(List<int>.from(currentFavorites));
    // تحديث الحالة فوراً (UI)
    //emit(currentFavorites);
    // حفظ القائمة الجديدة في الجهاز
    await _saveToPrefs(currentFavorites);

    try {
      await _apiService.toggleFavorite(productId);
    } catch (e) {
      // في حالة الفشل، نعود للحالة القديمة (اختياري حسب رغبتك)
      // لكن يجب أيضاً إعادة حفظ الحالة القديمة في الـ Prefs هنا إذا تراجعتِ
      log("حدث خطأ أثناء تحديث المفضلة في السيرفر: $e");
    }
  }
}
