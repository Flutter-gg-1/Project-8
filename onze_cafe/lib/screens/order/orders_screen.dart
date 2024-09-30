import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/order/order_cubit.dart';
import 'package:onze_cafe/screens/order/subviews/order_card_view.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => OrderCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            title: const Text('Orders').styled(
                color: C.primary(brightness),
                size: 20,
                weight: FontWeight.w800),
            centerTitle: true,
          ),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    OrderCardView(cubit: cubit, brightness: brightness)
                  ],
                ),
              )
            ],
          )),
        );
      }),
    );
  }
}
