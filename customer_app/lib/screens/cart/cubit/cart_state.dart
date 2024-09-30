part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class ShowCartState extends CartState {}

final class QueChangeState extends CartState {}

final class DelOrderState extends CartState {}

final class ErorState extends CartState {
  final String msg;

  ErorState({required this.msg});
}

final class OrderConformState extends CartState {}
