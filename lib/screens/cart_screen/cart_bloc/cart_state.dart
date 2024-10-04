part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoadingState extends CartState {}

final class CartLoadedState extends CartState {
  final List<OrderItemModel> items;
  final double totalPrice;

  CartLoadedState({required this.items, required this.totalPrice});
}

final class CartSuccessState extends CartState {
  final String message;

  CartSuccessState(this.message);
}

final class ErrorState extends CartState {
  final String message;

  ErrorState(this.message);
}