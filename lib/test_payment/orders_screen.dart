import 'package:flutter/material.dart';
import 'package:onze_cafe/test_payment/payment_mothods_screen.dart';

class OrdersScreen extends StatelessWidget {
  final int orderId = 1324; // Dummy order ID
  final int orderAmount = 100;

  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Order #$orderId'),
            const Text('Amount: 1.00 SAR'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to PaymentMethodsScreen when Pay Now button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentMethodsScreen(
                      orderId: orderId,
                      amount: orderAmount,
                    ),
                  ),
                );
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}