import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/screens/item_details/subviews/count_view.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    super.key,
  });
  //final CartItem item;

  void navigateToPayment(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const PaymentScreen()));

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => CartCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            title: Text("Cart"),
          ),
          body: SafeArea(
              child: Column(
            children: [
              Card(
                  color: C.bg1(brightness),
                  elevation: 4,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text("data"),
                      )
                    ],
                  ))
            ],
          )),
        );
      }),
    );
  }
}
