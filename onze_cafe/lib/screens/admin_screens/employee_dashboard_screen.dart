import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/menu_mgmt_screen.dart';
import 'package:onze_cafe/screens/admin_screens/orders_dashboard/orders_dashboard_screen.dart';
import 'package:onze_cafe/screens/admin_screens/reports_dashboard/reports_screen.dart';

class EmployeeDashboardScreen extends StatelessWidget {
  const EmployeeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: C.primary(brightness),
      appBar: AppBar(
        backgroundColor: C.primary(brightness),
        title: AspectRatio(aspectRatio: 7, child: Image(image: Img.logo1)),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hi employee").styled(
                        color: C.bg1(brightness),
                        size: 24,
                        weight: FontWeight.bold),
                    const Text("Keep shining, your effort matters!").styled(
                      color: C.bg1(brightness),
                      size: 14,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AspectRatio(
                    aspectRatio: 2.2, child: Image(image: Img.illustration10)),
              ),
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: C.bg1(brightness),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text("Employee Dashboard").styled(
                          weight: FontWeight.bold,
                          size: 22,
                          color: C.primary(brightness)),
                    ),
                    EmployeeDashboardView(
                        onTab: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReportsScreen()));
                        },
                        title: "Reports"),
                    EmployeeDashboardView(
                        onTab: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MenuMgmtScreen()));
                        },
                        title: "Menu"),
                    EmployeeDashboardView(
                        onTab: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MenuMgmtScreen()));
                        },
                        title: "Orders"),
                    EmployeeDashboardView(
                        onTab: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OrdersDashboardScreen()));
                        },
                        title: "Employees"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeDashboardView extends StatelessWidget {
  const EmployeeDashboardView(
      {super.key, required this.onTab, required this.title});
  final Function()? onTab;
  final String title;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: onTab,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 4,
                    spreadRadius: 3,
                    color: Colors.black12,
                    offset: Offset(0, 6))
              ], borderRadius: BorderRadius.circular(24), gradient: G.accent2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Image(image: Img.star, fit: BoxFit.contain),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(title).styled(
                            size: 20,
                            weight: FontWeight.bold,
                            color: C.primary(brightness)),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: C.secondary(brightness),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }
}
