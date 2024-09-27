import 'package:flutter/material.dart';
import 'package:onze_cafe/Auth%20Screens/otp_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OtpScreen(
      email: 'test@gmail.com',
    );
  }
}
