import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/enums/order_status.dart';
import 'package:onze_cafe/model/enums/order_status_img.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/model/placed_order.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  Timer? timer;
  int remainingTime = 120; // 2 minutes
  OrderStatus status = OrderStatus.placed;
  StatusImage img = StatusImage.an1;
    List<PlacedOrder> orders = [];


  OrderDetailsCubit() : super(OrderDetailsInitial());
   void fetchOrders() {
    orders =
        MockData().placedOrders.where((order) => order.userId == '1').toList();
  }
   List<CartItem> fetchCartItems(PlacedOrder order) {
    return MockData()
        .cart
        .where((cartItem) => cartItem.placedOrderId == order.id)
        .toList();
  }

  MenuItem? fetchMenuItem(CartItem cart) {
    return MockData()
        .menuItems
        .where((item) => item.id == cart.menuItemId)
        .toList()
        .firstOrNull;
  }
  double totalPrice(PlacedOrder order) {
    var total = 0.0;
    var cartItems = fetchCartItems(order);
    for (var cartItem in cartItems) {
      var quantity = cartItem.quantity;
      var item = fetchMenuItem(cartItem);
      if (item != null) {
        total += item.price * quantity;
      }
    }
    return total;
  }

  void startCountdown() {
    emit(UpdateOrderDetailsState());

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        updateOrderStatus();
        emit(UpdateOrderDetailsState());
      } else {
        timer.cancel();
        emit(SuccessOrderDetailsState());
      }
    });
  }

  void updateOrderStatus() {
    if (remainingTime <= 30) {
      status = OrderStatus.onTheWay;
      img = StatusImage.an3;
    } else if (remainingTime <= 60) {
      status = OrderStatus.ready;
      img = StatusImage.an3;
    } else if (remainingTime <= 90) {
      status = OrderStatus.preparing;
      img = StatusImage.an2;
    } else {
      status = OrderStatus.placed;
      img = StatusImage.an1;
    }
  }

  String get orderStatusText => status.name();
  AssetImage get orderStatusImage => img.image();
  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
