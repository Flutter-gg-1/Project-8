import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/user_model.dart';
import 'package:customer_app/screens/auth/login_screen.dart';
import 'package:customer_app/screens/order_history/history_screen.dart';
import 'package:customer_app/screens/order_history/customer_orders_screen.dart';
import 'package:customer_app/screens/profile/profile_screen.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffD7D1CA),
      child: SingleChildScrollView(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: context.getWidth(multiply: 0.02),
          vertical: context.getHeight(multiply: 0.1),
        ),
        child: Column(
          children: [
            Image.asset('assets/image/logo.png'),
            context.addSpacer(multiply: 0.02),
            Text(
              'Welcome ${user?.firstName ?? 'User'}',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Rosarivo'),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.05),
                vertical: context.getWidth(multiply: 0.05),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.05),
                vertical: context.getWidth(multiply: 0.02),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: kElevationToShadow[4],
                color: const Color(0xffEFEDEA),
              ),
              child: const Text(
                'Onze Cafe\nWhere Artisanal Coffee\nMeets a Warm, Inviting\nAtmosphere — A Place to Savor Handcrafted Beverages and Build Lasting Connections',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Rosarivo'),
              ),
            ),
            context.addSpacer(multiply: 0.03),
            CustomButton(
              title: '     Profile',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ));
              },
              fixedSize: Size(context.getWidth(multiply: 0.4),
                  context.getHeight(multiply: 0.06)),
            ),
            context.addSpacer(multiply: 0.03),
            CustomButton(
              title: '   My Order',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerOrdersScreen(),
                    ));
              },
              fixedSize: Size(context.getWidth(multiply: 0.4),
                  context.getHeight(multiply: 0.06)),
            ),
            context.addSpacer(multiply: 0.03),
            CustomButton(
              title: '    History',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ));
              },
              fixedSize: Size(context.getWidth(multiply: 0.4),
                  context.getHeight(multiply: 0.06)),
            ),
            context.addSpacer(multiply: 0.08),
            CustomButton(
              title: '     Logout',
              titleColor: Colors.grey,
              onPressed: () {
                authLocator.get<AuthLayer>().logOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              fixedSize: Size(context.getWidth(multiply: 0.4),
                  context.getHeight(multiply: 0.06)),
            ),
            context.addSpacer(multiply: 0.04),
            const Text(
              'Version: 1.0.0',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Rosarivo'),
            ),
          ],
        ),
      ),
    );
  }
}
