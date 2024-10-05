import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/date_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/enums/order_status.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/network_functions.dart';

import '../../../../model/order.dart';
import '../orders_dashboard_cubit.dart';

class OrderStatusView extends StatelessWidget {
  const OrderStatusView({
    super.key,
    required this.order,
    required this.cubit,
  });

  final Order order;
  final OrdersDashboardCubit cubit;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
        color: C.bg3(brightness),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order #${order.id?.substring(0, 4)}").styled(
                      color: C.primary(brightness),
                      size: 16,
                      weight: FontWeight.w600),
                  Text(order.createdAt!.toFormattedStringWithTime())
                      .styled(size: 12, weight: FontWeight.w300)
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: G.accent,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 2,
                      )
                    ]),
                child: Row(
                  children: [
                    StatusIconView(
                      cubit: cubit,
                      icon: CupertinoIcons.cart_fill,
                      onTap: () =>
                          cubit.updateOrder(context, order, OrderStatus.placed),
                      status: OrderStatus.placed,
                      currentStatus: order.status,
                    ),
                    StatusIconView(
                      cubit: cubit,
                      icon: CupertinoIcons.timer,
                      onTap: () => cubit.updateOrder(
                          context, order, OrderStatus.preparing),
                      status: OrderStatus.preparing,
                      currentStatus: order.status,
                    ),
                    StatusIconView(
                      cubit: cubit,
                      icon: CupertinoIcons.bell_fill,
                      onTap: () =>
                          cubit.updateOrder(context, order, OrderStatus.ready),
                      status: OrderStatus.ready,
                      currentStatus: order.status,
                    ),
                    StatusIconView(
                      cubit: cubit,
                      icon: CupertinoIcons.checkmark_alt,
                      onTap: () => cubit.updateOrder(
                          context, order, OrderStatus.onTheWay),
                      status: OrderStatus.onTheWay,
                      currentStatus: order.status,
                    ),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class StatusIconView extends StatelessWidget {
  const StatusIconView({
    super.key,
    required this.cubit,
    required this.status,
    required this.onTap,
    required this.icon,
    required this.currentStatus,
  });

  final OrdersDashboardCubit cubit;
  final IconData icon;
  final OrderStatus status;
  final String currentStatus;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: status.name() == currentStatus
                ? C.primary(brightness)
                : C.bg1(brightness),
            gradient: status.name() == currentStatus ? G.secondary2 : null,
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: C.accent(brightness),
            ),
          )),
    );
  }
}
