import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation2/feauture/review/data/cart_repo.dart';
import '../../../core/utils/pref_helpers.dart';
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
  // جوه كلاس CartCubit
  Future<void> loadCartFromPrefs() async {
    emit(CartLoading());
    try {
      final savedCartId = await PrefHelpers.getCartId();
      if (savedCartId != null && savedCartId.isNotEmpty) {
        final cart = await repo.getCart(savedCartId);
        emit(CartLoaded(cart));
      } else {
        emit(CartError("No Cart ID found"));
      }
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
      await loadCart();
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
    bool isInCart(int productId) {
      if (state is CartLoaded) {
        final items = (state as CartLoaded).cart.cartItems;
        return items.any((item) => item.id == productId);
      }
      return false;
    }

  Future<void> toggleCartItem(int productId) async {
    try {

      if (isInCart(productId)) {
        await deleteItem(productId);
      } else {
        await addItem(productId);
      }

    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
