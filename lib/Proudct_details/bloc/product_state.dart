part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductDetailsLoading extends ProductState {}

class ProductDetailsSuccess extends ProductState {
  final String message;
  ProductDetailsSuccess(this.message);
}

class ProductDetailsFailure extends ProductState {
  final String error;
  ProductDetailsFailure(this.error);
}

class ProductQuantityUpdated extends ProductState {
  final int quantity;
  ProductQuantityUpdated(this.quantity);
}

class ProductSizeUpdated extends ProductState {
  final String selectedSize;
  ProductSizeUpdated(
      [this.selectedSize = '8 oz']); // وضع قيمة افتراضية عند التهيئة
}

class ProductItemsUpdated extends ProductState {
  final List<OrderItemModel> cartItems; // قائمة العناصر المضافة

  ProductItemsUpdated(this.cartItems);
}
