import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/placed_order.dart';
import 'package:onze_cafe/screens/order_details/order_details_screen.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  List<PlacedOrder> orders = [];

  void fetchOrders() {
    orders =
        MockData().placedOrders.where((order) => order.userId == '1').toList();
  }

  void navigateToOrderDetails(BuildContext context) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const OrderDetailsScreen()));
}
