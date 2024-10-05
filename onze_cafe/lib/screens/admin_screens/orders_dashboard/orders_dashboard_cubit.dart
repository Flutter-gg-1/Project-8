import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/network_functions.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/subviews/bill_view.dart';

import '../../../model/menu_item.dart';
import '../../../reusable_components/animated_snackbar.dart';

part 'orders_dashboard_state.dart';

class OrdersDashboardCubit extends Cubit<OrdersDashboardState> {
  OrdersDashboardCubit(BuildContext context) : super(OrdersDashboardInitial()) {
    initialLoad(context);
  }
  bool isGradientToggled = false;
  List<Order> orders = [];
  List<MenuItem> menuItems = [];

  void initialLoad(BuildContext context) async {
    emitLoading();
    menuItems = await fetchMenuItems(context);
    if (context.mounted) orders = await fetchOrders(context);
    orders.sort((a, b) {
      if (a.createdAt == null || b.createdAt == null) {
        return 0;
      }
      return b.createdAt!.compareTo(a.createdAt!);
    });

    emitUpdate();
  }

  showBillView(BuildContext context, Order order) async {
    var cartItems = await fetchOrderItems(context, order);

    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return BillView(
            order: order,
            cartItems: cartItems,
            menuItems: menuItems,
          );
        },
      );
    }
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
