import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/screens/order/network_functions.dart';
import 'package:onze_cafe/screens/order_details/order_details_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../reusable_components/animated_snackbar.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(BuildContext context) : super(OrderInitial()) {
    initialLoad(context);
  }

  List<Order> orders = [];

  Future<void> initialLoad(BuildContext context) async {
    orders = await fetchUserOrders(context);
    await Future.delayed(Duration(seconds: 1));
    emitUpdate();
  }

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> handleRefresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void navigateToOrderDetails(BuildContext context, Order order) {
    final price = order.price;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetailsScreen(order: order),
      ),
    );
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
