import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/screens/order_details/order_details_screen.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());
  void navigateToOrderDetails(BuildContext context) =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const OrderDetailsScreen()));

}
