import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/screens/Employee%20Screen/employee_bloc/employee_bloc.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:onze_cafe/utils/launch_url.dart';
import 'package:sizer/sizer.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  void initState() {
    log('${locator.get<DataLayer>().orders}');
    super.initState();
  }

  Future<void> _refreshOrders() async {
    // إعادة تحميل البيانات من خلال استدعاء الحدث
    final bloc = context.read<EmployeeBloc>();
    bloc.add(LoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeBloc()..add(LoadEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          drawer: Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Drawer(
              backgroundColor: const Color(0xff87B1C5),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      'Hi ${locator.get<DataLayer>().user?.name ?? ''}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    accountEmail: Text(
                      locator.get<DataLayer>().user?.email ?? '',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/pfp.png'),
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff3d6b7d),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.circle_outlined, color: Colors.white),
                    title: InkWell(
                      onTap: () {
                        // Menu Item Logic
                      },
                      child: const Text('Add Menu Item',
                          style: TextStyle(color: Colors.white)),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.black),
                    title: const Text('Log Out',
                        style: TextStyle(color: Colors.black)),
                    onTap: () {
                      locator.get<DataLayer>().logout();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const FirstScreen()),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: const Color(0xff3D6B7D),
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Image.asset(
              'assets/onze logo.png',
              height: 200,
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refreshOrders,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.h,
                          child: Image.asset('assets/sticker3.png'),
                        ),
                        const Column(
                          children: [
                            SizedBox(height: 20),
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xffA8483D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Coffee For You',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff3D6B7D),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Orders:',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff3D6B7D),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BlocConsumer<EmployeeBloc, EmployeeState>(
                    listener: (context, state) {
                      if (state is ReadySuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Item Marked Ready Successfully!!')),
                        );
                      }
                      if (state is CancelSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Item Cancelled Successfully!!')),
                        );
                      }
                      if (state is ErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error Occurred')));
                      }
                    },
                    builder: (context, state) {
                      final bloc = context.read<EmployeeBloc>();
                      if (state is LoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is SuccessfullLoadState) {
                        log('${locator.get<DataLayer>().orders}');
                        return Column(
                          children: [
                            ...List.generate(state.orders.length, (index) {
                              final order = state.orders[index];
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 8),
                                    child: Container(
                                      height: 124,
                                      width: 340,
                                      padding: const EdgeInsets.only(
                                          right: 12, top: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              child: Image.network(
                                                locator
                                                        .get<DataLayer>()
                                                        .orders[index]['item']
                                                    ['image_url'],
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      locator
                                                              .get<DataLayer>()
                                                              .orders[index]
                                                          ['item']['name'],
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                      '${locator.get<DataLayer>().orders[index]['quantity']}'),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                    'Price: SAR ${locator.get<DataLayer>().orders[index]['price']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff3D6B7D),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  bloc.add(
                                                      ReadyEvent(order: order));
                                                },
                                                child: const Text(
                                                  'Ready',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffA8483D),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: const Text(
                                                              'Do you want to Cancel this order?'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  bloc.add(
                                                                      CancelEvent(
                                                                          order:
                                                                              order));
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'YES')),
                                                            TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'No'))
                                                          ],
                                                        );
                                                      });
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                          ],
                        );
                      }
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'No Orders',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 90,
                  )
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 80,
            width: double.infinity,
            color: const Color(0xff3D6B7D),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.home, color: Colors.white),
                      onPressed: () => launchURL('https://your-home-url.com'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.white),
                      onPressed: () => launchURL('https://facebook.com'),
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () => launchURL('https://your-shop-url.com'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person, color: Colors.white),
                      onPressed: () =>
                          launchURL('https://your-profile-url.com'),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () => launchURL('https://your-website-url.com'),
                  child: const Text(
                    'For more information visit our website',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
