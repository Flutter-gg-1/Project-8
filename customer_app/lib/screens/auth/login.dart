import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('customer_app/assets/image/background.png'),
      )),
      child: Scaffold(
        body: Column(
          children: [
            Image.asset('customer_app/assets/image/logo.png')
          ],
        ),
      ),
    );
  }
}
