import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/screens/menu/menu_screen.dart';
import 'package:employee_app/screens/order/order_screen.dart';
import 'package:employee_app/widget/button/home_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Image
          Image.asset(
            'assets/image/background_coffee_top.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          context.addSpacer(multiply: 0.1),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/image/onze_logo_bg.png'),
              SizedBox(
                height: context.getHeight(multiply: 0.07),
              ),
              HomeButtonEmp(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const MenuScreen();
                    },
                  ));
                },
                isIcon: false,
                height: context.getHeight(multiply: 0.12),
                width: context.getWidth(multiply: 0.8),
                color: const Color(0xffCB918B).withOpacity(0.70),
                text: 'Menu',
                textSize: 23,
              ),
              SizedBox(
                height: context.getHeight(multiply: 0.05),
              ),
              HomeButtonEmp(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const OrderScreen();
                    },
                  ));
                },
                isIcon: true,
                height: context.getHeight(multiply: 0.12),
                width: context.getWidth(multiply: 0.8),
                color: const Color(0xffCB918B).withOpacity(0.70),
                text: 'Orders',
                textSize: 23,
              ),
            ],
          ),

          context.addSpacer(multiply: 0.12),
          Divider(),
          Expanded(
            child: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}
