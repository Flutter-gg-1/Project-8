import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:onze_cafe/utils/launch_url.dart';
import 'package:sizer/sizer.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Hi ${locator.get<DataLayer>().user!.name}',
                  style: const TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  locator.get<DataLayer>().user!.email,
                  style: const TextStyle(color: Colors.white70),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage:
                      AssetImage(locator.get<DataLayer>().user!.imageUrl),
                ),
                decoration: const BoxDecoration(
                  color: Color(0xff3d6b7d),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.circle_outlined, color: Colors.white),
                title: InkWell(
                  onTap: () {},
                  child: const Text('Add Menu Item',
                      style: TextStyle(color: Colors.white)),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff3D6B7D),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/onze logo.png',
          height: 200,
        ),
      ),
      body: Column(
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
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Good Morning',
                      style: TextStyle(
                          fontSize: 12,
                          color: Color(0xffA8483D),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Coffee For You',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff3D6B7D),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Orders:',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff3D6B7D),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 14.h,
                      child: Image.asset('assets/coffe_of_thday.png')),
                  const Column(
                    children: [
                      Text(
                        'Name of Item',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff3D6B7D),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '# Quantity',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff3D6B7D),
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '\$price',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xffC3C6C9),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Ready')),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Cancel')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
                  onPressed: () => launchURL(urls[0]),
                ),
                IconButton(
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  onPressed: () => launchURL(urls[1]),
                ),
                IconButton(
                  icon: const Icon(Icons.shape_line, color: Colors.white),
                  onPressed: () => launchURL(urls[2]),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () => launchURL(urls[3]),
                ),
              ],
            ),
            InkWell(
                onTap: () => launchURL(urls[4]),
                child: const Text(
                  'For more information visit our website',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
