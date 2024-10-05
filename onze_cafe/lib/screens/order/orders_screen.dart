import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/screens/order/order_cubit.dart';
import 'package:onze_cafe/screens/order/subviews/order_card_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => OrderCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            leading: CustomeBackBtn(brightness: brightness),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image(image: Img.star4),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Orders").styled(
                        size: 20,
                        color: C.primary(brightness),
                        weight: FontWeight.bold),
                  ],
                ),
              ),
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      children: cubit.orders
                          .map((order) => OrderCardView(
                              cubit: cubit,
                              placedOrder: order,
                              brightness: brightness))
                          .toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
