import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/placed_order.dart';
import 'package:onze_cafe/reusable_components/buttons/circle_btn.dart';
import 'package:onze_cafe/screens/order_details/order_details_cubit.dart';
import 'package:onze_cafe/screens/order_details/subviews/details_view.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    required this.orderId,
    required this.price,
    super.key,
  });
  final String orderId;
  final double price;
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..startCountdown(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderDetailsCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(backgroundColor: C.bg1(brightness)),
          body: Center(
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                    builder: (context, state) {
                      if (state is OrderDetailsInitial ||
                          state is UpdateOrderDetailsState) {
                        return Column(
                          children: [
                            Text(cubit.orderStatusText).styled(
                              weight: FontWeight.w400,
                              size: 20,
                            ),
                            ClipOval(
                              child: Image(
                                image: cubit.orderStatusImage,
                              ),
                            ),
                            // TimerView(cubit: cubit),
                            Text(
                              formatTime(cubit.remainingTime),
                            ).styled(
                              size: 26.0,
                              color: C.primary(brightness),
                              weight: FontWeight.bold,
                            ),
                          ],
                        );
                      } else if (state is SuccessOrderDetailsState) {
                        return const Center(
                            child: Text("Your order has been delivered!"));
                      } else if (state is ErrorOrderDetailsState) {
                        return const Center(child: Text("An error occurred!"));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return DetailsViwe(
                            brightness: brightness,
                            cubit: cubit,
                            price: price,
                            placedOrder: PlacedOrder(
                                id: orderId, userId: '1', status: 'placed'),
                          );
                        },
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomPaint(
                                  size: Size(0, 90), painter: CircleBtn()),
                            ),
                          ],
                        ),
                        Text('Order Details').styled(
                            size: 16,
                            color: C.bg1(brightness),
                            weight: FontWeight.bold)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
