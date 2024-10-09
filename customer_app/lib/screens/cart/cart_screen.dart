import 'package:customer_app/helper/extinsion/size_config.dart';

import 'package:customer_app/screens/cart/cubit/cart_cubit.dart';
import 'package:customer_app/screens/payment/pay_screen.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/cart_widget/custome_text_tow_direction.dart';
import 'package:customer_app/widget/cart_widget/seprate_divider.dart';
import 'package:customer_app/widget/coulmn/cart_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moyasar/moyasar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CartCubit>();
        cubit.showCart();
        return BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is OrderConformState) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return PayScreen(
                    paymentConfig: state.paymentConfig,
                  );
                },
              )).then(
                (paymentResponse) {
                  if (paymentResponse is PaymentResponse) {
                    cubit.checkOut(paymentResponse: paymentResponse);
                  }
                },
              );
            }

            if (state is BuySussesState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.green,
              ));
            }
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xffD7D1CA),
            appBar: AppBar(
              backgroundColor: const Color(0xffD7D1CA),
              centerTitle: true,
              title: const Text('Cart'),
            ),
            body: SafeArea(
                child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.getHeight(multiply: 0.05),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.getHeight(multiply: 0.042)),
                          child: Column(
                            children: [
                              TextWithTowDirection(
                                isRightClickable: true,
                                onPressed: () {
                                  cubit.delAllOrder();
                                },
                                leftText: 'Total Order',
                                leftTextColor: Colors.black,
                                leftTextSize: 20,
                                rightText: 'Clear',
                                rightTextColor: const Color(0xffA8483D),
                                rightTextSize: 20,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ),
                              SizedBox(
                                height: context.getHeight(multiply: 0.04),
                              ),
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  return CartColumn(cubit: cubit);
                                },
                              ),
                              SizedBox(
                                height: context.getHeight(multiply: 0.01),
                              ),
                              SeparatorDivider(
                                color: Colors.black.withOpacity(0.60),
                                height: 2,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Order Summary',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              BlocBuilder<CartCubit, CartState>(
                                builder: (context, state) {
                                  return Column(
                                    children: List.generate(
                                      cubit.cartLis.length,
                                      (index) {
                                        return TextWithTowDirection(
                                          isRightClickable: false,
                                          onPressed: () {},
                                          leftText: cubit.cartLis[index]
                                              .productModel!.name!,
                                          leftTextColor: Colors.black,
                                          leftTextSize: 20,
                                          rightText:
                                              "x${cubit.cartLis[index].quantity} ${cubit.cartLis[index].productModel!.price! * cubit.cartLis[index].quantity!} SAR",
                                          rightTextColor:
                                              Colors.black.withOpacity(0.40),
                                          rightTextSize: 20,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: context.getHeight(multiply: 0.01),
                              ),
                              SeparatorDivider(
                                color: Colors.black.withOpacity(0.60),
                                height: 2,
                              ),
                              SizedBox(
                                height: context.getHeight(multiply: 0.02),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: context.getHeight(multiply: 0.215),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: Color(0xffD9D9D9)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getHeight(multiply: 0.03),
                        vertical: context.getHeight(multiply: 0.02)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return TextWithTowDirection(
                                leftText: 'Total',
                                rightText: "${cubit.priceTotal}",
                                leftTextSize: 20,
                                rightTextSize: 20,
                                leftTextColor: Colors.black,
                                rightTextColor: Colors.black,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                isRightClickable: false);
                          },
                        ),
                        CustomButton(
                          title: 'CheckOut',
                          onPressed: () {
                            cubit.buyCart();
                          },
                          icon: Icons.arrow_forward_ios_rounded,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        );
      }),
    );
  }
}
