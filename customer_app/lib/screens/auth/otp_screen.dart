import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  final String email;
  const OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.getHeight(multiply: 0.05),
        top: context.getHeight(multiply: 0.01),
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/background2.png'),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.06)),
            child: Column(
              children: [
                Image.asset('assets/image/logo.png'),
                context.addSpacer(multiply: 0.04),
                const Text(
                  'OTP',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3D6B7D)),
                ),
                context.addSpacer(multiply: 0.02),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-mail : $email',
                      style: const TextStyle(
                          color: Color(0xff87B1C5),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                    context.addSpacer(multiply: 0.02),
                const Pinput(
                  length: 6,
                ),
                context.addSpacer(multiply: 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don’t send OTP?',
                      style: TextStyle(color: Color(0xff87B1C5), fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupScreen(),
                            ));
                      },
                      child: const Text(
                        'ResendOTP',
                        style: TextStyle(
                            color: Color(0xffA8483D),
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                context.addSpacer(multiply: 0.04),
                CustomButton(
                  title: 'Verify',
                  onPressed: () {},
                  icon: Icons.arrow_forward_ios_rounded,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
