part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

final class CartLoadEvent extends CartEvent {}

final class DeleteAllCartEvent extends CartEvent {}

final class CartDeleteItemEvent extends CartEvent {
  final OrderItemModel item;

  CartDeleteItemEvent(this.item);
}

final class CartUpdateQuantityEvent extends CartEvent {
  final OrderItemModel item;
  final int quantity;

  CartUpdateQuantityEvent(this.item, this.quantity);
}
