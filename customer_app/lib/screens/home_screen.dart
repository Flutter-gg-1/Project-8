import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/user_model.dart';
import 'package:customer_app/screens/cart/cart_screen.dart';
import 'package:customer_app/screens/menu/menu_option.dart';
import 'package:customer_app/screens/menu/menu_types.dart';

import 'package:customer_app/screens/profile/profile_screen.dart';

import 'package:customer_app/screens/order_history/history_screen.dart';

import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        key: _scaffoldKey,
        extendBodyBehindAppBar: true,
        //separate it later
        drawer: Drawer(
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
                  'Welcome ${user.firstName}',
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
                    // navigate to profile
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
                          builder: (context) => const CartScreen(),
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
                  onPressed: () {},
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
        ),
        appBar: AppBar(
          title: Image.asset('assets/image/logo_small.png'),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                FontAwesome.bars_staggered_solid,
                color: Color(0xffA8483D),
              )),
          actions: [
            IconButton(
                onPressed: () {
                  log("${productLocator.get<ProductLayer>().cartItem}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                icon: const Icon(
                  Iconsax.shop_add_bold,
                  color: Color(0xffA8483D),
                )),

            InkWell(
              onTap: () {

                Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ));

              },
              child: const CircleAvatar(
                backgroundColor: Color(0xffd9d9d9),
                backgroundImage: AssetImage('assets/image/appBarProfile.png'),
              ),
            ),

            SizedBox(
              width: context.getWidth(multiply: 0.01),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(
            bottom: context.getHeight(multiply: 0.05),
            top: context.getHeight(multiply: 0.1),
          ),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/background2.png'),
                  fit: BoxFit.cover)),
          child: Center(
            child: Column(
              children: [
                const CustomTextFormFeild(
                  label: '',
                  hint: 'Find your coffee',
                  prefixIcon: Icon(Bootstrap.search_heart),
                ),
                context.addSpacer(multiply: 0.02),
               Image.asset('assets/image/homegroup.png'),
                context.addSpacer(multiply: 0.02),
                const MenuTypes(),
                context.addSpacer(multiply: 0.01),
                SizedBox(
                  height: context.getHeight(multiply: 0.4),
                  child: const MenuOption(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
