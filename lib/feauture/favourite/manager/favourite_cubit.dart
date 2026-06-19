import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation2/feauture/favourite/data/favourite_model.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';
import 'package:graduation2/feauture/home/manager/fav_apiserves.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteApiService _apiService;
  static const String _favKey = 'favorite_ids';

  FavoriteCubit(this._apiService) : super(FavoriteLoading()) {
    _initFavoriteData(); // تحميل الكاش والـ API فور إنشاء الكيوبيت
  }

  // --- وظيفة مساعدة لمعرفة هل المنتج مفضل أم لا في الـ UI ---
  bool isFavorite(int productId) => state.favoriteIds.contains(productId);

  // --- تحميل البيانات الأولية (الكاش ثم السيرفر) ---
  Future<void> _initFavoriteData() async {
    // 1. شحن الـ IDs المحفوظة في الجهاز بسرعة عشان الـ UI ما يتأخرش
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedFavs = prefs.getStringList(_favKey);
    List<int> cachedIds = [];

    if (savedFavs != null) {
      cachedIds = savedFavs.map((e) => int.parse(e)).toList();
      emit(FavoriteLoaded(favoriteIds: cachedIds, products: []));
    }

    // 2. جلب القائمة الكاملة من السيرفر لتحديث الـ IDs والـ Products معاً
    await getFavorites();
  }

  // --- 1. جلب المنتجات المفضلة من السيرفر ---
  Future<void> getFavorites() async {
    try {
      // بنحافظ على الـ IDs الحالية عشان الـ UI ميعملش Flicker للقلوب أثناء التحميل
      emit(FavoriteLoading(favoriteIds: state.favoriteIds, products: state.products));

      final fetchedProducts = await _apiService.getMyFavourites();

      // استخراج الـ IDs من الـ Models القادمة من السيرفر لمزامنتها
      final serverIds = fetchedProducts.map((e) => e.id).toList();
      await _saveToPrefs(serverIds);

      emit(FavoriteLoaded(favoriteIds: serverIds, products: fetchedProducts));
    } catch (e) {
      emit(FavoriteError(e.toString(), favoriteIds: state.favoriteIds, products: state.products));
    }
  }

  // --- 2. حذف منتج مباشرة من شاشة المفضلة ---
  Future<void> removeFavorite(int id) async {
    final currentIds = List<int>.from(state.favoriteIds);
    final currentProducts = List<FavouriteModel>.from(state.products);

    // تحديث لحظي (Optimistic Update)
    currentIds.remove(id);
    currentProducts.removeWhere((element) => element.id == id);

    emit(FavoriteLoaded(favoriteIds: currentIds, products: currentProducts));
    await _saveToPrefs(currentIds);

    try {
      await _apiService.removeFavorite(id);
    } catch (e) {
      log("حدث خطأ أثناء حذف المفضلة: $e");
      // في حالة الفشل نرجع الداتا السابقة (اختياري)
    }
  }

  // --- 3. عمل Toggle للمنتج (إضافة/حذف) من شاشة الـ Home ---
  Future<void> toggleFavorite(int productId) async {
    final currentIds = List<int>.from(state.favoriteIds);
    final currentProducts = List<FavouriteModel>.from(state.products);

    if (currentIds.contains(productId)) {
      currentIds.remove(productId);
      currentProducts.removeWhere((element) => element.id == productId);
    } else {
      currentIds.add(productId);

      // ✅ إضافة كائن مؤقت ببيانات أساسية لتحديث طول المصفوفة والعداد فوراً
      currentProducts.add(
        FavouriteModel(
          id: productId,
          name: '',
          imageUrl: '',
          price: 0.0, // تم استخدام double لتطابق الـ Model
        ),
      );
    }

    emit(FavoriteLoaded(favoriteIds: currentIds, products: currentProducts));
    await _saveToPrefs(currentIds);

    try {
      await _apiService.toggleFavorite(productId);
    } catch (e) {
      log("حدث خطأ أثناء تحديث المفضلة في السيرفر: $e");
    }
  }

  // --- 4. عمل Toggle للمواد (Materials) ---
  Future<void> toggleFavoriteForMaterial(int materialId) async {
    final currentIds = List<int>.from(state.favoriteIds);
    final currentProducts = List<FavouriteModel>.from(state.products);

    if (currentIds.contains(materialId)) {
      currentIds.remove(materialId);
      currentProducts.removeWhere((element) => element.id == materialId);
    } else {
      currentIds.add(materialId);

      // ✅ إضافة كائن مؤقت للمادة أيضاً
      currentProducts.add(
        FavouriteModel(
          id: materialId,
          name: '',
          imageUrl: '',
          price: 0.0,
        ),
      );
    }

    emit(FavoriteLoaded(favoriteIds: currentIds, products: currentProducts));
    await _saveToPrefs(currentIds);

    try {
      await _apiService.toggleFavoriteForMaterial(materialId);
    } catch (e) {
      log("حدث خطأ أثناء تحديث مفضلة المواد في السيرفر: $e");
    }
  }

  // --- حفظ الـ IDs في الـ SharedPreferences ---
  Future<void> _saveToPrefs(List<int> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = favorites.map((e) => e.toString()).toList();
    await prefs.setStringList(_favKey, stringList);
  }
}