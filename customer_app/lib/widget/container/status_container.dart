import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stepindicator/flutter_stepindicator.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({
    super.key,
    required this.bloc,
    required this.color,
    required this.test,
  });

  final OrderBloc bloc;
  final List<Color> color;
  final List<Widget> test;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Center(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  return Text(
                    bloc.orderStatus,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: color[bloc.statusIndex]),
                  );
                },
              ),
            ),
          ),
          context.addSpacer(multiply: 0.03),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return SizedBox(
                height: 20,
                width: context.getWidth(multiply: 0.7),
                child: FlutterStepIndicator(
                  height: 20,
                  disableAutoScroll: false,
                  list: const [
                    Text('1'),
                    Text('2'),
                    Text('3'),
                    Text('4'),
                  ],
                  onChange: (i) {},
                  page: bloc.statusIndex,
                ),
              );
            },
          ),
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Center(child: test[bloc.statusIndex]));
            },
          )
        ],
      ),
    );
  }
}
