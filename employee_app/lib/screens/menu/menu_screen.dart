import 'dart:developer';

import 'package:employee_app/data_layer/auth_layer.dart';
import 'package:employee_app/data_layer/product_layer.dart';
import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/screens/menu/add_product_screen.dart';
import 'package:employee_app/screens/menu/show_menu_cubit/show_menu_cubit.dart';
import 'package:employee_app/screens/profile/profile_screen.dart';
import 'package:employee_app/services/setup.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:employee_app/widget/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final UserModel? user = authLocator.get<AuthLayer>().user;
    final locator = productLocator.get<ProductLayer>();
    return BlocProvider(
      create: (context) => ShowMenuCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ShowMenuCubit>();
        return BlocListener<ShowMenuCubit, ShowMenuState>(
          listener: (context, state) {
            if (state is ShowAllMenuState) {
              Navigator.pop(context);
            }
            if (state is DelIthemState) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "item has been deltate",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.green,
              ));

              cubit.showMenu();
            }

            if (state is LodingState) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )));
            }
          },
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xffA8483D),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const AddProduct();
                  },
                )).then(
                  (value) async {
                    if (value == true) {
                      log("in the return");

                      await cubit.showMenu();
                    }
                  },
                );
              },
              child: const  Icon(Icons.add,color: Colors.white,),
            ),
            key: scaffoldKey,
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
                      'Welcome ${user?.firstName ?? 'Emp'}',
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
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(
                    FontAwesome.bars_staggered_solid,
                    color: Color(0xffA8483D),
                  )),
              actions: [
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
                    backgroundImage:
                        AssetImage('assets/image/appBarProfile.png'),
                  ),
                ),
                SizedBox(
                  width: context.getWidth(multiply: 0.03),
                )
              ],
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: constraints.maxWidth,
                  //height: constraints.maxHeight * 0.8,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth(multiply: 0.05),
                      vertical: context.getHeight(multiply: 0.02),
                    ),
                    child: Center(
                      child: Column(children: [
                        Image.asset('assets/image/menulogo.png'),
                        context.addSpacer(multiply: 0.04),
                        SizedBox(
                          height: constraints.maxHeight * 0.9,
                          child: BlocBuilder<ShowMenuCubit, ShowMenuState>(
                            builder: (context, state) {
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.75,
                                ),
                                itemCount: locator.menu.length,
                                itemBuilder: (context, index) => MenuItem(
                                  itemInfo: locator.menu[index],
                                  editFunction: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return AddProduct(
                                          productModel: locator.menu[index],
                                        );
                                      },
                                    )).then(
                                      (value) async {
                                        if (value == true) {
                                          log("in the return");

                                          await cubit.showMenu();
                                        }
                                      },
                                    );
                                  },
                                  removeFunction: () async {
                                    await cubit.delIthem(
                                        productId:
                                            locator.menu[index].productId);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
