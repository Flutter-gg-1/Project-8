import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<OrderItemModel> items = [];
  double totalPrice = 0;
  CartBloc() : super(CartInitial()) {
    on<CartLoadEvent>(loadCart);
    on<DeleteAllCartEvent>(deleteAllCart);
    on<CartDeleteItemEvent>(deleteItem);
    on<CartUpdateQuantityEvent>(updateQuantity);
  }

  FutureOr<void> loadCart(CartLoadEvent event, Emitter<CartState> emit) {
    emit(CartLoadingState());
    items = locator.get<DataLayer>().cart.items;
    totalPrice = getTotalPrice();
    emit(CartLoadedState(items: items, totalPrice: totalPrice));
  }

  FutureOr<void> deleteAllCart(
      DeleteAllCartEvent event, Emitter<CartState> emit) {
    locator.get<DataLayer>().cart.clearCart();
    totalPrice = 0;
    add(CartLoadEvent());
    emit(CartSuccessState('All items deleted successfully!'));
  }

  FutureOr<void> deleteItem(
      CartDeleteItemEvent event, Emitter<CartState> emit) {
    locator.get<DataLayer>().cart.items.remove(event.item);
    add(CartLoadEvent());
    emit(CartSuccessState('Item deleted successfully!'));
  }

  FutureOr<void> updateQuantity(
      CartUpdateQuantityEvent event, Emitter<CartState> emit) {
    for (var e in locator.get<DataLayer>().cart.items) {
      if (e.itemId == event.item.itemId) {
        e.quantity = event.quantity;
        break;
      }
    }
    totalPrice = getTotalPrice();
    emit(CartLoadedState(items: items, totalPrice: totalPrice));
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in locator.get<DataLayer>().cart.items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  Future<bool> processPayment(double totalPrice) async {
    pay();
    return true;
  }

  PaymentConfig pay() {
    final paymentConfig = PaymentConfig(
      publishableApiKey: '${dotenv.env['moyasar_test_key']}',
      amount: (totalPrice * 100).toInt(),
      description: 'Onze Order',
      metadata: {'orderId': '1', 'customer': 'customer'},
      creditCard: CreditCardConfig(saveCard: true, manual: false),
    );
    return paymentConfig;
  }

  void onPaymentResult(result, BuildContext context) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          saveOrder(totalPrice: totalPrice, orderId: locator.get<DataLayer>().order!.orderId);
          locator.get<DataLayer>().cart.clearCart();
          add(CartLoadEvent());
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment successful!'),
          ));
          break;
        case PaymentStatus.failed:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment failed. Try again.'),
          ));
          break;
        case PaymentStatus.initiated:
        case PaymentStatus.authorized:
        case PaymentStatus.captured:
      }
    }
  }
}
