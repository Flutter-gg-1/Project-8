import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';


class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PaymentMethods(),
      ),
    );
  }
}

class PaymentMethods extends StatelessWidget {
  PaymentMethods({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: dotenv.env['Moyasar_API']!,
    amount: 25758, // SAR 257.58
    description: 'Order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
    // applePay: ApplePayConfig(
    //   merchantId: dotenv.env['MERCHANT_ID']!,
    //   label: 'ABU_Mukhlef',
    //   manual: false,
    // ),
  );

  void onPaymentResult(result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          showMessage('Payment successful!');
          break;
        case PaymentStatus.failed:
          showMessage('Payment failed. Please try again.');
          break;
        case PaymentStatus.initiated:
          showMessage('Payment initiated. Please confirm.');
          break;
        case PaymentStatus.authorized:
          showMessage('Payment authorized. Awaiting capture.');
          break;
        case PaymentStatus.captured:
          showMessage('Payment captured successfully!');
          break;
      }
    }
  }

  void showMessage(String message) {
    // يمكنك استخدام Dialog أو SnackBar لعرض الرسائل
    print(message); // هنا نستخدم الطباعة لأغراض التصحيح
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApplePay(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        ),
        const Text("or"),
        CreditCard(
          config: paymentConfig,
          onPaymentResult: onPaymentResult,
        ),
      ],
    );
  }
}

