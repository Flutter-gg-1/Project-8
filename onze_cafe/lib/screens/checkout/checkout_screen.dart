import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:moyasar/moyasar.dart';
import 'package:onze_cafe/screens/checkout/checkout_cubit.dart';

import '../../extensions/color_ext.dart';

import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';

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
            child: Column(children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(
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
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Pick up Or Deliver?").styled(
                            size: 16,
                            color: C.primary(brightness),
                            weight: FontWeight.bold),
                      ),
                      BlocBuilder<CheckoutCubit, CheckoutState>(
                        builder: (context, state) {
                          if (state is SelectState) {
                            final cubit = context.read<CheckoutCubit>();
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: state.isPickupSelected,
                                      onChanged: (value) {
                                        cubit.togglePickup(value ?? false);
                                      },
                                      activeColor: C.secondary(brightness),
                                    ),
                                    Text("Pick up").styled(
                                      size: 16,
                                      weight: FontWeight.w600,
                                      color: C.primary(brightness),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: state.isDeliverSelected,
                                      onChanged: (value) {
                                        cubit.toggleDeliver(value ?? false);
                                      },
                                      activeColor: C.secondary(brightness),
                                    ),
                                    Text("Deliver").styled(
                                      size: 16,
                                      weight: FontWeight.w600,
                                      color: C.primary(brightness),
                                    ),
                                  ],
                                ),
                                if (state.isDeliverSelected) ...[
                                  SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter your class number").styled(
                                            size: 16,
                                            color: C.primary(brightness),
                                            weight: FontWeight.bold),
                                        CustomTextField(
                                          hintText: "A15",
                                          onChanged: (value) {
                                            cubit.updateClassNumber(value);
                                          },
                                          controller: cubit.textController,
                                          validation: (String value) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            );
                          }
                          return SizedBox();
                        },
                      ),
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
            ]),
          ),
        );
      }),
    );
  }
}
