import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graduation2/feauture/favourite/data/favourite_model.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';
import 'package:graduation2/feauture/home/manager/fav_apiserves.dart';

class MyFavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteApiService api;
  static const String _favKey = 'favorite_ids';

  // لستة محلية للاحتفاظ بالمنتجات والـ IDs داخل الـ memory للـ Cubit
  List<FavouriteModel> _products = [];
  List<int> _favoriteIds = [];

  // ✅ الـ Getters المفتوحة عشان شاشة الـ AppBar وباقي الشاشات تقدر تقرأ الأعداد دايماً
  List<FavouriteModel> get favorites => _products;
  List<int> get favoriteIds => _favoriteIds;

  MyFavoriteCubit(this.api) : super(FavoriteInitial()) {
    _initFavorites(); // تحميل الكاش أول ما الكيوبيت يشتغل
  }

  // دالة داخلية لتحميل الـ IDs المحفوظة في الجهاز لتلوين القلوب فوراً عند فتح الأبلكيشن
  Future<void> _initFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final List<String>? savedFavs = prefs.getStringList(_favKey);
      if (savedFavs != null) {
        _favoriteIds = savedFavs.map((e) => int.parse(e)).toList();
        // ✅ استخدام List.from لضمان التحديث
        emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
      }
    } catch (e) {
      log("Error loading cached favorites: $e");
    }
  }

  // دالة حفظ الـ IDs محلياً
  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stringList = _favoriteIds.map((e) => e.toString()).toList();
    await prefs.setStringList(_favKey, stringList);
  }

  // دالة فحص هل المنتج مفضل أم لا
  bool isFavorite(int productId) {
    return _favoriteIds.contains(productId);
  }

  // 1. جلب قائمة المفضلة كاملة من السيرفر
  Future<void> getFavorites() async {
    try {
      emit(FavoriteLoading());

      _products = await api.getMyFavourites();
      _favoriteIds = _products.map((e) => e.id ?? 0).where((id) => id != 0).toList();
      await _saveToPrefs();

      emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  // 2. دالة الـ Toggle الموحدة (إضافة / حذف) وتحديث الـ UI لحظياً
  Future<void> toggleFavorite(FavouriteModel product) async {
    final int productId = product.id!;

    final previousProducts = List<FavouriteModel>.from(_products);
    final previousIds = List<int>.from(_favoriteIds);

    // تحديث محلي فوري (Optimistic Update)
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
      _products.removeWhere((element) => element.id == productId);
    } else {
      _favoriteIds.add(productId);
      _products.add(product);
    }

    // ✅ التعديل الأهم: إطلاق نسخة جديدة تماماً بـ List.from عشان الـ AppBar يحس بالزيادة والنقصان فوراً
    emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
    await _saveToPrefs();

    try {
      await api.toggleFavorite(productId);
    } catch (e) {
      // في حال فشل السيرفر، تراجع عن التغييرات ورجع الحالة القديمة
      _products = previousProducts;
      _favoriteIds = previousIds;
      await _saveToPrefs();
      emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
      log("حدث خطأ أثناء تحديث المفضلة في السيرفر: $e");
    }
  }

  // 3. دالة الحذف المباشر
  Future<void> removeFavorite(int id) async {
    final previousProducts = List<FavouriteModel>.from(_products);
    final previousIds = List<int>.from(_favoriteIds);

    _favoriteIds.remove(id);
    _products.removeWhere((element) => element.id == id);

    // ✅ هنا برضه نمرر نسخة جديدة تماماً List.from
    emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
    await _saveToPrefs();

    try {
      await api.removeFavorite(id);
    } catch (e) {
      _products = previousProducts;
      _favoriteIds = previousIds;
      await _saveToPrefs();
      emit(FavoriteLoaded(products: List.from(_products), favoriteIds: List.from(_favoriteIds)));
      emit(FavoriteError(e.toString()));
    }
  }
}