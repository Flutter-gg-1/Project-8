import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/orders_dashboard/orders_dashboard_cubit.dart';
import 'package:onze_cafe/screens/orders_dashboard/subviews/orders_db_view.dart';

class OrdersDashboardScreen extends StatelessWidget {
  const OrdersDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => OrdersDashboardCubit(),
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
                padding: EdgeInsets.all(16),
                child: BlocBuilder<OrdersDashboardCubit, OrderDashboardState>(
                  builder: (context, state) {
                    int selectedIndex = -1;
                    if (state is OrderDashboardCardSelectedState) {
                      selectedIndex = state.selectedIndex;
                    }

                    return ListView(
                      children: [
                        Text("Orders Dashboard").styled(
                            weight: FontWeight.bold,
                            size: 22,
                            color: C.primary(brightness)),
                        SizedBox(
                          height: 10,
                        ),
                        OrderDisplay(
                          quantity: "111",
                          orders: "orders",
                          date: "date",
                          cubit: cubit,
                          selectedIndex: selectedIndex,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
