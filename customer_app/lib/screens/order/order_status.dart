import 'dart:developer';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:customer_app/shape/container_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..add(StartTimerEvent()),
      child: Builder(builder: (context) {
        final bloc = context.read<OrderBloc>();
        List<Widget> test = [
          Icon(
            Iconsax.timer_1_bold,
            color: Color(0xffA8483D),
          ),
          Icon(
            Iconsax.timer_1_bold,
            color: Color(0xffA8483D),
          ),
          Icon(
            Iconsax.timer_1_bold,
            color: Color(0xffA8483D),
          ),
          Lottie.network(
              'https://lottie.host/974f8698-fc20-4586-9636-1276a155e3fb/opaLH3arqC.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
        ];
        int? index;
        return Scaffold(
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
                        child: ListTile(
                          onTap: () {
                            log('Review from here');
                          },
                          title: const Text(
                            'Review Your Order',
                            style: TextStyle(
                                color: Color(0xffEFE3C8),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rosarivo'),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                context.addSpacer(multiply: 0.02),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth(multiply: 0.05),
                      vertical: context.getWidth(multiply: 0.03)),
                  width: context.getSize(
                      smallDivider: 0.8, largeDivider: 0.9, context: context),
                  height: context.getHeight(multiply: 0.35),
                  decoration: BoxDecoration(
                      color: const Color(0x40A8483D),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.getSize(
                            smallDivider: 0.22,
                            largeDivider: 0.4,
                            context: context),
                        height: context.getHeight(multiply: 0.035),
                        decoration: BoxDecoration(
                            color: const Color(0xff6F5860),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Center(
                          child: Text(
                            'Preparing',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffFC820A)),
                          ),
                        ),
                      ),
                      context.addSpacer(multiply: 0.03),
                      BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          return FlutterStepIndicator(
                            height: 20,
                            disableAutoScroll: false,
                            list: const [
                              Text('1'),
                              Text('2'),
                              Text('3'),
                              Text('4'),
                            ],
                            onChange: (i) {
                              log('=======0000===========');
                            },
                            page: bloc.statusIndex,
                          );
                        },
                      ),
                      //context.addSpacer(multiply: 0.04),
                      BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          if (state is ChangeStatusState) {
                            return SingleChildScrollView(
                                child: Center(child: test[bloc.statusIndex]));
                          }
                          return const Text('');
                        },
                      )
                    ],
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
