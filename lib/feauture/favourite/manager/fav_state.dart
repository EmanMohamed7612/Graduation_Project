

import 'package:graduation2/feauture/favourite/data/favourite_model.dart';

abstract class FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<FavouriteModel> products;

  FavoriteLoaded(this.products);
}

class FavoriteError extends FavoriteState {
  final String message;

  FavoriteError(this.message);
}