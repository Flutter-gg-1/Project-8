import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_screen.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/reports_screen.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportsScreen()));
              },
              child: Text('Reports')),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Menu')),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Orders')),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MenuMgmtScreen()));
              },
              child: Text('Employees')),
        ],
      ),
    );
  }
}
