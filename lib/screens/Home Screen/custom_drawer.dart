import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/About%20Screen/about_us.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/screens/Order_Tracking/order_trcking.dart';
import 'package:onze_cafe/screens/profile/profile.dart';
import 'package:onze_cafe/services/setup.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              locator.get<DataLayer>().user!.name,
              style: const TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              locator.get<DataLayer>().user!.email,
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/11.jpg'),
            ),
            decoration: const BoxDecoration(
              color: Color(0xff3d6b7d),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Profile', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.track_changes, color: Colors.black),
            title: const Text('Tracking order',
                style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OrderTracking()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.black),
            title:
                const Text('About Us', style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Log Out', style: TextStyle(color: Colors.black)),
            onTap: () {
              locator.get<DataLayer>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const FirstScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
