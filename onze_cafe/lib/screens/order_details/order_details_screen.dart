import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/enums/order_status_img.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_circle_btn.dart';
import 'package:onze_cafe/screens/order_details/order_details_cubit.dart';
import 'package:onze_cafe/screens/order_details/subviews/details_view.dart';
import 'package:onze_cafe/screens/order_details/subviews/timer_view.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    required this.order,
    super.key,
  });
  final Order order;
  String formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(1, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => OrderDetailsCubit(order)..startCountdown(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderDetailsCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            leading: CustomeBackBtn(brightness: brightness),
          ),
          body: Column(
            children: [
              BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Text(cubit.order?.status ?? '?').styled(
                        weight: FontWeight.w400,
                        size: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          TimerView(cubit: cubit),
                          Padding(
                            padding: const EdgeInsets.all(40),
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image(
                                  image: cubit.orderStatusImage.image(),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        formatTime(cubit.remainingTime),
                      ).styled(
                        size: 26.0,
                        color: C.primary(brightness),
                        weight: FontWeight.bold,
                      ),
                    ],
                  );
                },
              ),
              Spacer(),
              CustomCircleBtn(
                  brightness: brightness,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return DetailsView(
                          cubit: cubit,
                          placedOrder: order,
                        );
                      },
                    );
                  },
                  title: 'Order Details'),
            ],
          ),
        );
      }),
    );
  }
}
