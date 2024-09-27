import 'package:flutter/material.dart';

import '../extensions/img_ext.dart';

class PaymentConfirmScreen extends StatelessWidget {
  const PaymentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Screen'),
        centerTitle: true,
      ),
      body: const SafeArea(
          child: Column(
        children: [Image(image: Img.logo1)],
      )),
    );
  }
}
