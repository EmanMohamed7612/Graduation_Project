

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

abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavouriteModel> products; // لعرض المنتجات في شاشة المفضلة
  final List<int> favoriteIds;         // لتلوين القلوب في الـ Home والـ Details فوراً

  FavoriteLoaded({required this.products, required this.favoriteIds});
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}