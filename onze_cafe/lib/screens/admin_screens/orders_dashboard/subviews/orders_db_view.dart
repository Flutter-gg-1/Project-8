import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/subviews/bill_view.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/subviews/order_status.dart';

import '../orders_dashboard_cubit.dart';

class OrderDisplay extends StatelessWidget {
  const OrderDisplay(
      {super.key,
      required this.quantity,
      required this.orders,
      required this.date,
      required this.cubit,
      required this.selectedIndex});
  final String quantity;
  final String orders;
  final String date;
  final OrdersDashboardCubit cubit;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return BillView(brightness: brightness);
          },
        );
      },
      child: OrderStatusView(
          brightness: brightness,
          quantity: quantity,
          orders: orders,
          date: date,
          cubit: cubit,
          selectedIndex: selectedIndex),
    );
  }
}
