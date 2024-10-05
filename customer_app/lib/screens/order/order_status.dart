import 'dart:developer';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:customer_app/shape/container_shape.dart';
import 'package:customer_app/widget/bottom_sheet/order_review.dart';
import 'package:customer_app/widget/container/status_container.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lottie/lottie.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.order});
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..add(StartTimerEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<OrderBloc>();
        bloc.orderId = order.orderId;

        List<Color> color = const [
          Colors.orange,
          Colors.blue,
          Colors.green,
          Colors.red
        ];
        List<Widget> test = [
          Lottie.network(
              'https://lottie.host/62e756a8-c2a6-491c-9243-75bac153c403/O6lI273ehV.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
          Lottie.network(
              'https://lottie.host/974f8698-fc20-4586-9636-1276a155e3fb/opaLH3arqC.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
          Lottie.network(
              'https://lottie.host/6724961a-5d22-4aa3-8780-4b1e760b8843/8u7eipDiqv.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
          Lottie.network(
              'https://lottie.host/dfec9960-84ff-47fa-a324-4e6599e1422a/x1dSOsiAVa.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
        ];
        return BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Column(
                children: [
                  Image.asset('assets/image/status_cup.png'),
                  const Text('20 min',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                  const Text(
                    'For Your Order',
                    style: TextStyle(
                        color: Color(0xff3D6B7D),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rosarivo'),
                  ),
                  context.addSpacer(multiply: 0.02),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CustomPaint(
                        size: Size(
                            context.getSize(
                                smallDivider: 0.8,
                                largeDivider: 0.8,
                                context: context),
                            40),
                        painter: RPSCustomPainter(),
                      ),
                      Positioned(
                        left: context.getWidth(multiply: 0.05),
                        top: -6,
                        child: SizedBox(
                          width: context.getSize(
                              smallDivider: 0.75,
                              largeDivider: 0.75,
                              context: context),
                          child: OrderReview(order: order),
                        ),
                      ),
                    ],
                  ),
                  context.addSpacer(multiply: 0.02),
                  BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return StatusContainer(
                          orderStatus: bloc.orderStatus,
                          statusIndex: bloc.statusIndex,
                          color: color,
                          test: test);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
