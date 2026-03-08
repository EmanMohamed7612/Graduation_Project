import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;
  final String cartId;

  CartCubit({
    required this.repo,
    required this.cartId,
  }) : super(CartInitial());

  /// 🔹 Load Cart
  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      final cart = await repo.getCart(cartId);
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// 🔹 Add Item
  Future<void> addItem(int itemId) async {
    try {
      final cart = await repo.addItem(
        cartId: cartId,
        itemId: itemId,
      );
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// 🔹 Increase / Decrease
  Future<void> updateQuantity({
    required int productId,
    required bool isIncrement,
    required String cartId,
  }) async {
    try {
      final cart = await repo.updateQuantity(
        cartId: cartId,
        productId: productId,
        isIncrement: isIncrement,
      );
      emit(CartLoaded(cart));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  /// 🔹 Delete
  Future<void> deleteItem(int itemId) async {
    try {
      final cart = await repo.deleteItem(
        cartId: cartId,
        itemId: itemId,
      );

      if (cart != null) {
        emit(CartLoaded(cart));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
