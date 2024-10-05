import 'package:flutter/material.dart';

class PaymentConfirmScreen extends StatelessWidget {
  const PaymentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Confirmed!'),
      ),
      body: Padding(padding: const EdgeInsets.all(16.0), child: Text('Hello')),
    );
  }
}
