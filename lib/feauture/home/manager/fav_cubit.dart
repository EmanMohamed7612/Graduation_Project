import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(int productId) {
    final current = List<int>.from(state);

    if (current.contains(productId)) {
      current.remove(productId);
    } else {
      current.add(productId);
    }

    emit(current);
  }

  bool isFavorite(int id) {
    return state.contains(id);
  }
}