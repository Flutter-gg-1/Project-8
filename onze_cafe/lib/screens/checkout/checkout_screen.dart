import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_circle_btn.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/checkout/checkout_cubit.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => CheckoutCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CheckoutCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            leading: CustomeBackBtn(brightness: brightness),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
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
                    ],
                  ),
                ),
              ),
              //TODOs make it on right 
              AspectRatio(
                aspectRatio: 1.4,
                child: Image(
                  image: Img.illustration13,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomCircleBtn(
                brightness: brightness,
                onTap: () => cubit.navigateToConfirmPayment(context),
                title: 'Confirm Payment',
              )
            ],
          ),
        );
      }),
    );
  }
}
