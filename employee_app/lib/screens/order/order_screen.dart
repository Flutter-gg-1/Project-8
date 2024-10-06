import 'dart:developer';

import 'package:employee_app/data_layer/auth_layer.dart';
import 'package:employee_app/data_layer/product_layer.dart';
import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/order_model.dart';
import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/screens/auth/login_scrren.dart';
import 'package:employee_app/screens/order/cubit/order_list_cubit.dart';
import 'package:employee_app/screens/profile/profile_screen.dart';
import 'package:employee_app/services/setup.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:employee_app/widget/inkwell/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final UserModel? user = authLocator.get<AuthLayer>().user;
    final menu = productLocator.get<ProductLayer>().menu;
    return BlocProvider(
      create: (context) => OrderListCubit()..startTimer(),
      child: Builder(builder: (context) {
        final cubit = context.read<OrderListCubit>();

        return BlocListener<OrderListCubit, OrderListState>(
          listener: (context, state) {
            log("${state.runtimeType}");
            if (state is NoLodingState) {
              Navigator.pop(context);
            }
            if (state is OrderShowState) {
              log("very good");
            }

            if (state is LoadingState) {
              log("in loding");
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => const Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )));
            }
            if (state is ErorrState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.msg,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
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
                        // navigate to profile
                      },
                      fixedSize: Size(context.getWidth(multiply: 0.4),
                          context.getHeight(multiply: 0.06)),
                    ),
                    context.addSpacer(multiply: 0.03),
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
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getWidth(multiply: 0.05),
                  vertical: context.getHeight(multiply: 0.15)),
              child: Column(
                children: [
                  Image.asset('assets/image/orderlogo.png'),
                  BlocBuilder<OrderListCubit, OrderListState>(
                    builder: (context, state) {
                      return Column(
                          children: cubit.orderList.isNotEmpty
                              ? cubit.orderList
                                  .map(
                                    (e) => OrderItem(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Container(
                                            height: context.getHeight(
                                                multiply: 0.35),
                                            width:
                                                context.getWidth(multiply: 1),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: context.getWidth(
                                                    multiply: 0.05),
                                                vertical: context.getHeight(
                                                    multiply: 0.05)),
                                            decoration: const BoxDecoration(
                                                color: Color(0xffeeedea),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30),
                                                  topRight: Radius.circular(30),
                                                )),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Order Summary',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xffA8483D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rosarivo'),
                                                  ),
                                                  const Divider(),
                                                  context.addSpacer(
                                                      multiply: 0.02),
                                                  Text(
                                                    'Order Time : ${e.time}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA8483D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rosarivo'),
                                                  ),
                                                  context.addSpacer(
                                                      multiply: 0.01),
                                                  Text(
                                                    'Preparation Time : ${e.totalPreparationTime}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA8483D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rosarivo'),
                                                  ),
                                                  context.addSpacer(
                                                      multiply: 0.01),
                                                  Text(
                                                    'Total Price : ${e.totalPrice} RS',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA8483D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rosarivo'),
                                                  ),
                                                  Text(
                                                    '\nOrder Items :\n${e.orderDetailsLis.map((element) => menu.firstWhere((e) => e.productId == element.productId).name).join('\nquantity : ${e.orderDetailsLis.first.quantity}\n\n')}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffA8483D),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Rosarivo'),
                                                  ),
                                                  const Center(
                                                    child: Text(
                                                      'Enjoy',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xffA8483D),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Rosarivo'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      order: e,
                                      cubit: cubit,
                                      orderInfo: e.orderDetailsLis.first,
                                      userName:
                                          'Order ${e.customerId?.substring(e.customerId!.length - 4, e.customerId!.length)}',
                                    ),
                                  )
                                  .toList()
                              : [
                                  const Center(
                                    child: Text(
                                      'No Order yet',
                                      style: TextStyle(
                                          fontSize: 32, color: Colors.grey),
                                    ),
                                  )
                                ]);
                    },
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
