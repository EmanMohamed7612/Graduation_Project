import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/favourite/data/favourite_model.dart';
import 'package:graduation2/feauture/favourite/manager/fav_state.dart';
import 'package:graduation2/feauture/home/manager/fav_apiserves.dart';

class MyFavoriteCubit extends Cubit<FavoriteState> {
  final FavoriteApiService api;

  MyFavoriteCubit(this.api) : super(FavoriteLoading());

  List<FavouriteModel> products = [];

  Future<void> getFavorites() async {
    try {
      emit(FavoriteLoading());

      products = await api.getMyFavourites();

      emit(FavoriteLoaded(products));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await api.removeFavorite(id);

      products.removeWhere((element) => element.id == id);

      emit(FavoriteLoaded(List.from(products)));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }
}
