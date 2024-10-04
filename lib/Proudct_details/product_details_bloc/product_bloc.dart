import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/services/setup.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductDetailsBloc extends Bloc<ProductEvent, ProductDetailsState> {
  int quantity = 1;
  String selectedSize = '8 oz';
  ProductDetailsBloc() : super(ProductInitial()) {
    on<AddToCartEvent>(addToCart);
    on<ChangeQuantityEvent>(changeQuantity);
    on<ChangeSizeEvent>(changeSize);
  }

  FutureOr<void> addToCart(
      AddToCartEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      await locator.get<DataLayer>().addItem(
            item: OrderItemModel.fromJson({
              'item_id': event.itemId,
              'order_id': event.orderId,
              'quantity': event.quantity,
              'price': event.price,
            }),
            quantity: event.quantity
          );
      emit(ProductDetailsSuccess('Added to cart!'));
    } catch (e) {
      emit(ProductDetailsFailure('Failed to add to cart. $e'));
    }
  }

  FutureOr<void> changeQuantity(
      ChangeQuantityEvent event, Emitter<ProductDetailsState> emit) {
    quantity = event.quantity;
    emit(ProductQuantityUpdated(quantity));
  }

  FutureOr<void> changeSize(
      ChangeSizeEvent event, Emitter<ProductDetailsState> emit) {
    selectedSize = event.selectedSize;
    emit(ProductSizeUpdated(selectedSize));
  }
}
