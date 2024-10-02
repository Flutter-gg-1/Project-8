import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Menu Mgmt')),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Order Mgmt')),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Employee Mgmt')),
        ],
      ),
    );
  }
}
