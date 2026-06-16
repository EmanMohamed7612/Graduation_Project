// 👈 ضيفنا الـ import ده
import 'package:equatable/equatable.dart';
import 'package:graduation2/feauture/review/data/cart_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartDto cart;

  const CartLoaded(this.cart);

  // ✅ السطرين دول هما السر! بنقول للبلُوك قارن الـ State بناءً على عناصر السلة وعددها
  @override
  List<Object?> get props => [cart, cart.cartItems.length];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}