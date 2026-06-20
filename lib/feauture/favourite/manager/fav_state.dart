

/*import 'package:graduation2/feauture/favourite/data/favourite_model.dart';

abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavouriteModel> products;

  FavoriteLoaded(this.products);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}*/
import 'package:graduation2/feauture/favourite/data/favourite_model.dart';

abstract class FavoriteState {
  final List<int> favoriteIds;
  final List<FavouriteModel> products;

  FavoriteState({this.favoriteIds = const [], this.products = const []});
}

// الحالة الابتدائية أو التحميل
class FavoriteLoading extends FavoriteState {
  FavoriteLoading({super.favoriteIds, super.products});
}

// حالة النجاح بعد استرجاع أو تحديث البيانات
class FavoriteLoaded extends FavoriteState {
  FavoriteLoaded({required super.favoriteIds, required super.products});
}

// حالة حدوث خطأ
class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError(this.message, {super.favoriteIds, super.products});
}