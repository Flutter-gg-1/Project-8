import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
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
                    Text("Checkout").styled(
                        size: 20,
                        color: C.primary(brightness),
                        weight: FontWeight.bold),
                  ],
                ),
              ),
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
