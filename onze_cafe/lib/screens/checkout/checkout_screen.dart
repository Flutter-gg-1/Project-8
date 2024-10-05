import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/screens/checkout/checkout_cubit.dart';

import '../../extensions/color_ext.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(totalPrice),
      child: Builder(builder: (context) {
        final cubit = context.read<CheckoutCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(
                    CupertinoIcons.chevron_left_square_fill,
                    size: 30,
                    color: C.primary(brightness),
                  ))),
          body: SafeArea(
              child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BlocBuilder<CheckoutCubit, CheckoutState>(
                            builder: (context, state) {
                              return cubit.paymentConfig == null
                                  ? Text('')
                                  : CreditCard(
                                      config: cubit.paymentConfig!,
                                      onPaymentResult: (result) {
                                        cubit.onPaymentResult(context, result);
                                      },
                                    );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      }),
    );
  }
}
