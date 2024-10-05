import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/subviews/order_status.dart';

import 'orders_dashboard_cubit.dart';

class OrdersDashboardScreen extends StatelessWidget {
  const OrdersDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => OrdersDashboardCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<OrdersDashboardCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(CupertinoIcons.chevron_left_square_fill),
              iconSize: 40,
              color: C.primary(brightness),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  C.bg1(brightness),
                  C.bg3(brightness),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text("Orders Dashboard").styled(
                        weight: FontWeight.bold,
                        size: 22,
                        color: C.primary(brightness)),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<OrdersDashboardCubit, OrdersDashboardState>(
                      builder: (context, state) {
                        return Expanded(
                          child: ListView(
                            children: cubit.orders
                                .map(
                                  (order) => TextButton(
                                    onPressed: () =>
                                        cubit.showBillView(context, order),
                                    child: OrderStatusView(
                                        cubit: cubit, order: order),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
