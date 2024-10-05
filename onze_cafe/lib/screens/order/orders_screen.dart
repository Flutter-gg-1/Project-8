import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/custom_refresh/refresh.dart';
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
          body: Column(
            children: [
              BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderInitial) cubit.fetchOrders();
                  return Expanded(
                    child: Refresh(
                      refreshController: cubit.refreshController,
                     onRefresh: () async {
                cubit.emitLoading();
                await cubit.handleRefresh();
                cubit.refreshController.refreshCompleted();
                cubit.emitUpdate();
              },
                      bgColor: C.bg1(brightness),
                      gif: Img.loading,
                      child: ListView(
                        children: cubit.orders
                            .map((order) => OrderCardView(
                                cubit: cubit,
                                placedOrder: order,
                                brightness: brightness))
                            .toList(),
                      ),
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
