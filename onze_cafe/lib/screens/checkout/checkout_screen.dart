import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/payment_confirm_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  void navigateToConfirmPayment(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PaymentConfirmScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextButton(
                    onPressed: () => navigateToConfirmPayment(context),
                    child: const Text('Confirm Payment'))
              ],
            ),
          )
        ],
      )),
    );
  }
}
