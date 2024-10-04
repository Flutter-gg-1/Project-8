part of 'product_bloc.dart';

@immutable
abstract class ProductDetailsState {}

class ProductInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsSuccess extends ProductDetailsState {
  final String message;
  ProductDetailsSuccess(this.message);
}

class ProductDetailsFailure extends ProductDetailsState {
  final String error;
  ProductDetailsFailure(this.error);
}

class ProductQuantityUpdated extends ProductDetailsState {
  final int quantity;
  ProductQuantityUpdated(this.quantity);
}

class ProductSizeUpdated extends ProductDetailsState {
  final String selectedSize;
  ProductSizeUpdated([this.selectedSize = '8 oz']);
}

class ProductItemsUpdated extends ProductDetailsState {
  final List<OrderItemModel> cartItems;

  ProductItemsUpdated(this.cartItems);
}
