import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/setup.dart';

class EmployeeScreen extends StatelessWidget {
  const EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Drawer(
            backgroundColor: const Color(0xff87B1C5),
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                      backgroundImage:
                          AssetImage(locator.get<DataLayer>().user!.imageUrl),
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xff87B1C5),
                    ),
                  ),
                  ListTile(
                    leading:
                        const Icon(Icons.circle_outlined, color: Colors.white),
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
        ),
        appBar: AppBar(),
        body: const Column(
          children: [
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Orders:',
              style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff3D6B7D),
                  fontWeight: FontWeight.bold),
            ),
            // ...List.generate(5, (index) {
            //   return const Text('data');
            // })
          ],
        ),
        bottomSheet: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(color: Color(0xff3D6B7D)),
          
        ));
  }
}
