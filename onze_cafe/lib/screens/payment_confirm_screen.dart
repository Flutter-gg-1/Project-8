import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/primary_btn_view.dart';
import 'package:onze_cafe/screens/menu/menu_screen.dart';

import '../extensions/color_ext.dart';

class PaymentConfirmScreen extends StatelessWidget {
  const PaymentConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: C.bg1(brightness),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: Img.animatedOnze),
              const SizedBox(height: 24),
              Text('Your Order has been\n placed successfully').styled(
                  size: 24,
                  color: C.secondary(brightness),
                  weight: FontWeight.bold,
                  align: TextAlign.center),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                        'Thank you for choosing us. Feel free to continue shopping with us and explore our wide range of coffee selection')
                    .styled(
                        size: 14,
                        color: C.primary(brightness),
                        weight: FontWeight.w500,
                        align: TextAlign.center),
              ),
              const SizedBox(height: 16),
              PrimaryBtnView(
                  title: 'Back to Menu',
                  callback: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MenuScreen())))
            ],
          ),
        ),
      ),
    );
  }
}
