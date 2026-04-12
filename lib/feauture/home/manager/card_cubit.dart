
/*import 'dart:developer';
=======
import 'dart:developer';
>>>>>>> origin/book-session
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/pref_helpers.dart';
import 'card_apiserves.dart';

class CartCubit extends Cubit<List<int>> {
  final CartApiService api;

  CartCubit(this.api) : super([]);

  Future<void> addToCart(int productId) async {
    // 1. هاتي الـ CartId من الـ Preferences
    final cartId = await PrefHelpers.getCartId();

    if (cartId == null || cartId.isEmpty) {
      log('❌ CartCubit: Cart ID is missing! Make sure you saved it.');
      return;
    }

    // 2. تأكدي إن المنتج مش مضاف قبل كده عشان الـ Counter ميزدش عالفاضي
    if (state.contains(productId)) {
      log('ℹ️ CartCubit: Item $productId already exists in local state.');
      return;
    }

    // 3. تحديث الـ UI فوراً (Optimistic Update)
    // بنعمل Copy من اللستة القديمة ونضيف الجديد عشان BlocBuilder يحس بالتغيير
    final updatedList = List<int>.from(state)..add(productId);
    emit(updatedList);
    log('✅ CartCubit: UI Updated locally. Total items: ${state.length}');

    try {
      // 4. نبعت للسيرفر (التوكن هيتضاف لوحده من الـ DioClient)
      await api.addItemToCart(
        cartId: cartId!,
        itemId: productId,
      );
      log('🚀 CartCubit: Item added to server successfully.');
    } catch (e) {
      log('⚠️ CartCubit: Failed to sync with server. Error: $e');

      // لو عايزة لما يحصل فشل في السيرفر تشيلي العنصر من الـ AppBar:
      // final rollbackList = List<int>.from(state)..remove(productId);
      // emit(rollbackList);
    }
  }

  // ميثود عشان لما تحبي تمسحي كل اللي في الكارت (مثلاً عند الـ Logout)
  void clearCart() => emit([]);
<<<<<<< HEAD
}*/

