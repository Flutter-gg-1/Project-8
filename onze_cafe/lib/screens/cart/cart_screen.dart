import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/cart/subviews/card_item_view.dart';
import 'package:onze_cafe/screens/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });

  void navigateToPayment(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const PaymentScreen()));

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => CartCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<CartCubit>();

        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: C.bg1(brightness),
            title: Text("Cart").styled(
                color: C.primary(brightness),
                size: 20,
                weight: FontWeight.bold),
          ),
          body: SafeArea(
            child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              if (state is CartInitial) {
                cubit.fetchMenuItems();
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: cubit.cartItems
                          .map((item) => CartItemView(
                              cubit: context.read<CartCubit>(), item: item))
                          .toList(),
                    ),
                  ),
                  TextButton(
                    onPressed: () => navigateToPayment(context),
                    child: const Text('Proceed to Payment'),
                  ),
                ],
              );

              // if (cartItems.isEmpty) {
              //   return Center(
              //       child: AspectRatio(
              //           aspectRatio: 2.3, child: Image(image: Img.box)));
              // }
            }),
          ),
        );
      }),
    );
  }
}
