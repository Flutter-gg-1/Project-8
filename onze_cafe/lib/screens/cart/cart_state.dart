part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class LoadingState extends CartState {}

final class UpdateUIState extends CartState {}

final class CartUpdatedState extends CartState {
  final List<CartItem> cartItems;

  CartUpdatedState(this.cartItems);
}

final class UpdatedCountState extends CartInitial {
  final int selectedCountIndex;

  UpdatedCountState(this.selectedCountIndex);
}
