import 'dart:developer';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/cart/cart_screen.dart';
import 'package:customer_app/screens/menu/menu_option.dart';
import 'package:customer_app/screens/menu/menu_types.dart';
import 'package:customer_app/screens/profile/profile_screen.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/TextFormFeild/custom_text_form_feild.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        drawer: const Drawer(
          backgroundColor: Color(0xffD7D1CA),
        ),
        appBar: AppBar(
          title: Image.asset('assets/image/logo_small.png'),
          centerTitle: true,
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
              width: context.getWidth(multiply: 0.02),
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
                context.addSpacer(),
                const MenuTypes(),
                SizedBox(
                  height: context.getHeight(multiply: 0.6),
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
