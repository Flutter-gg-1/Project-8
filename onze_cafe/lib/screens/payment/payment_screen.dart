import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/screens/payment/payment_cubit.dart';

import '../../extensions/color_ext.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(totalPrice),
      child: Builder(builder: (context) {
        final cubit = context.read<PaymentCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: CustomeBackBtn(brightness: brightness),
            title: Text('Payment').styled(
                size: 22,
                weight: FontWeight.bold,
                color: C.primary(brightness)),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocBuilder<PaymentCubit, PaymentState>(
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
          ),
        );
      }),
    );
  }
}
