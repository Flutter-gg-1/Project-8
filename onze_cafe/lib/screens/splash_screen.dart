import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/reusable_components/primary_btn_view.dart';
import 'package:onze_cafe/reusable_components/secondary_btn_view.dart';

import 'auth/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void navigateToAuth(BuildContext context, bool isSignup) =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => AuthScreen(isSignup: isSignup)));

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: C.bg1(brightness),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: Img.logo3, fit: BoxFit.contain),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryBtnView(
                              title: 'Sign In',
                              callback: () => navigateToAuth(context, false)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SecondaryBtnView(
                            title: 'Sign Up',
                            callback: () => navigateToAuth(context, true)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
