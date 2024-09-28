part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartUpdatedState extends CartState {
  final List<CartItem> cartItems;

  CartUpdatedState(this.cartItems);
}

