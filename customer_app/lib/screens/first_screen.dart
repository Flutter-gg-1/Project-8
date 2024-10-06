import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/auth/login_screen.dart';
import 'package:customer_app/screens/home/home_screen.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLogin = authLocator.get<AuthLayer>().box.hasData('user');
    return Container(
      padding: EdgeInsets.only(
          bottom: context.getHeight(multiply: 0.05),
          top: context.getHeight(multiply: 0.1)),
      decoration: const BoxDecoration(
          color: Color(0xffD7D1CA),
          image: DecorationImage(
              image: AssetImage('assets/image/first.png'), fit: BoxFit.cover)),
      child: Scaffold(
        floatingActionButton: CustomButton(
          title: 'Get Coffee',
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: () {
            isLogin
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ))
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ));
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/image/logo.png'),
              context.addSpacer(),
            ],
          ),
        ),
      ),
    );
  }
}
