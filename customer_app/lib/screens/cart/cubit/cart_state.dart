part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class ShowCartState extends CartState {}

final class QueChangeState extends CartState {}

final class DelOrderState extends CartState {}

final class ErrorState extends CartState {
  final String msg;

  ErrorState({required this.msg});
}

final class BuySucssesState extends CartState {
  final String msg;

  BuySucssesState({required this.msg});
}

final class OrderConformState extends CartState {
  final PaymentConfig paymentConfig;

  OrderConformState({required this.paymentConfig});
}
