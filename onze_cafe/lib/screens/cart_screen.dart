import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  void navigateToPayment(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const PaymentScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextButton(
                    onPressed: () => navigateToPayment(context),
                    child: const Text('Navigate to Payment'))
              ],
            ),
          )
        ],
      )),
    );
  }
}
