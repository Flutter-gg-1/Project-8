import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentMethodsScreen extends StatelessWidget {
  final int orderId;
  final int amount;

  PaymentMethodsScreen({required this.orderId, required this.amount});

  // Payment Configuration for Moyasar
  final paymentConfig = PaymentConfig(
    publishableApiKey: 'pk_test_xWUPFwQABVUruCau7j64Cvm7tyrqFBHkeB4he8RY',
    amount: 100, // SAR 1
    description: 'Order #1324',
    metadata: {'orderId': '1324', 'customer': 'John Doe'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    applePay: ApplePayConfig(merchantId: '????', label: 'Cafe', manual: false),
  );

  void onPaymentResult(result, BuildContext context) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment successful!'),
          ));
          Navigator.pop(context, 'Payment successful');
          break;
        case PaymentStatus.failed:
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment failed. Try again.'),
          ));
          break;
        case PaymentStatus.initiated:
        case PaymentStatus.authorized:
        case PaymentStatus.captured:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select a payment method for Order #$orderId'),
            const SizedBox(height: 20),
            ApplePay(
              config: paymentConfig,
              onPaymentResult: (result) => onPaymentResult(result, context),
            ),
            const Text("or"),
            CreditCard(
              config: paymentConfig,
              onPaymentResult: (result) => onPaymentResult(result, context),
            ),
          ],
        ),
      ),
    );
  }
}
