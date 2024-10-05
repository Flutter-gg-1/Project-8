import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/enums/order_status.dart';
import 'package:onze_cafe/model/enums/order_status_img.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/model/order.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  Timer? timer;
  int remainingTime = 1000;
  OrderStatus status = OrderStatus.placed;
  StatusImage img = StatusImage.an1;
  Order? order;
  StatusImage orderStatusImage = StatusImage.an3;

  OrderDetailsCubit(Order order) : super(OrderDetailsInitial()) {
    fetchOrder(order);
  }
  void fetchOrder(Order order) {
    this.order = order;
    updateImage();
    emitUpdate();
  }

  void startCountdown() {
    emitUpdate();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        emitUpdate();
      } else {
        timer.cancel();
        emitUpdate();
      }
    });
  }

  void updateImage() {
    if (order?.status != null) {
      switch (order!.status) {
        case 'on the way':
          orderStatusImage = StatusImage.an4;
        case 'Working on your coffee':
          orderStatusImage = StatusImage.an3;
        case 'Your coffee is ready':
          orderStatusImage = StatusImage.an2;
        default:
          orderStatusImage = StatusImage.an1;
      }
    }
  }

  void emitUpdate() => emit(UpdateUIState());

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
