import 'package:flutter/material.dart';
import 'package:onze_cafe/reusable_components/buttons/primary_btn_view.dart';
import 'package:onze_cafe/reusable_components/buttons/secondary_btn_view.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_screen.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/orders_dashboard_screen.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/reports_screen.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          padding: EdgeInsets.all(24),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2,
          ),
          children: [
            SecondaryBtnView(
                title: 'Reports',
                callback: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ReportsScreen()));
                }),
            SecondaryBtnView(
                title: 'Menu',
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuMgmtScreen()));
                }),
            SecondaryBtnView(
                title: 'Orders',
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrdersDashboardScreen()));
                }),
            SecondaryBtnView(
                title: 'Employees',
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MenuMgmtScreen()));
                }),
          ],
        ),
      ),
    );
  }
}
