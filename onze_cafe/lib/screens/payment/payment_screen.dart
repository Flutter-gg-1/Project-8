import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/animation/animated_img_view.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/screens/payment/network_functions.dart';
import 'package:onze_cafe/screens/payment/payment_cubit.dart';

import '../../extensions/color_ext.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.totalPrice});
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(context, totalPrice),
      child: Builder(builder: (context) {
        final cubit = context.read<PaymentCubit>();
        final brightness = Theme.of(context).brightness;
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: CustomeBackBtn(brightness: brightness),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Image(image: Img.star4),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Payment").styled(
                                  size: 20,
                                  color: C.primary(brightness),
                                  weight: FontWeight.bold),
                            ],
                          ),
                        ),
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
                                          cubit.onPaymentResult(
                                              context, result);
                                        },
                                      );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AnimatedImgView(
                              img: Image(
                                width: context.screenWidth * 0.5,
                                image: Img.illustration13,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
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
