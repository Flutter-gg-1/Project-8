import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/auth/signup_screen.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: context.getHeight(multiply: 0.05),
        top: context.getHeight(multiply: 0.2),
      ),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/image/background2.png'),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/image/logo.png'),
              context.addSpacer(multiply: 0.04),
              const Text(
                'Greeting',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3D6B7D)),
              ),
              context.addSpacer(multiply: 0.02),
              CustomTextFormFeild(
                label: 'E-mail',
                keyboardType: TextInputType.emailAddress,
                hint: 'example@gmail.com',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter an email address'),
                      backgroundColor: Colors.red,
                    ));
                  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                      .hasMatch(value)) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please enter a valid email address'),
                      backgroundColor: Colors.red,
                    ));
                  }
                  return null;
                },
              ),
              context.addSpacer(multiply: 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don’t have an account?',
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
                      'Create',
                      style: TextStyle(
                        color: Color(0xff87B1C5),
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff87B1C5),
                        decorationThickness: 2,
                      ),
                    ),
                  )
                ],
              ),
              context.addSpacer(multiply: 0.04),
              CustomButton(
                title: 'Login',
                onPressed: () {},
                icon: Icons.arrow_forward_ios_rounded,
              )
            ],
          ),
        ),
      ),
    );
  }
}
