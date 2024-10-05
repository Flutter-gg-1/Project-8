import 'dart:developer';

import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/order_history/cubit/order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';

class PayScreen extends StatelessWidget {
  const PayScreen({super.key, required this.paymentConfig});

  final PaymentConfig paymentConfig;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => OrderShowCubit(),
        child: Builder(
          builder: (context) {
             final cubit = context.read<OrderShowCubit>();
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Payment'),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: context.getWidth(multiply: 0.05)),
                child: Column(
                  children: [
                    context.addSpacer(multiply: 0.2),
                    CreditCard(
                        config: paymentConfig,
                        onPaymentResult: (PaymentResponse paymentResponse) {
                          log("here is pay page");
                           cubit.orderList = [];
                          Navigator.of(context).pop(paymentResponse);
                        }),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
