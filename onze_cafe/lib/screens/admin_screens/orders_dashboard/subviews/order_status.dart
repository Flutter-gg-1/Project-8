import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../orders_dashboard_cubit.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    super.key,
    required this.brightness,
    required this.quantity,
    required this.orders,
    required this.date,
    required this.cubit,
    required this.selectedIndex,
  });

  final Brightness brightness;
  final String quantity;
  final String orders;
  final String date;
  final OrdersDashboardCubit cubit;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: C.bg3(brightness),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order #$quantity").styled(
                      color: C.primary(brightness),
                      size: 20,
                      weight: FontWeight.w600),
                  Text(orders).styled(),
                  Text(date).styled()
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: G.accent,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.black26,
                        blurRadius: 6,
                        spreadRadius: 2,
                      )
                    ]),
                child: Row(
                  children: [
                    Status(
                        brightness: brightness,
                        cubit: cubit,
                        icon: CupertinoIcons.cart_fill,
                        isToggled: selectedIndex == 0,
                        onTap: () {
                          cubit.setActiveIcon(0);
                        }),
                    Status(
                        brightness: brightness,
                        cubit: cubit,
                        icon: CupertinoIcons.timer,
                        isToggled: selectedIndex == 1,
                        onTap: () {
                          cubit.setActiveIcon(1);
                        }),
                    Status(
                        brightness: brightness,
                        cubit: cubit,
                        icon: CupertinoIcons.bell_fill,
                        isToggled: selectedIndex == 2,
                        onTap: () {
                          cubit.setActiveIcon(2);
                        }),
                    Status(
                        brightness: brightness,
                        cubit: cubit,
                        icon: CupertinoIcons.checkmark_alt,
                        isToggled: selectedIndex == 3,
                        onTap: () {
                          cubit.setActiveIcon(3);
                        }),
                    SizedBox(
                      width: 8,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class Status extends StatelessWidget {
  const Status({
    super.key,
    required this.brightness,
    required this.cubit,
    required this.icon,
    required this.isToggled,
    required this.onTap,
  });

  final Brightness brightness;
  final OrdersDashboardCubit cubit;
  final IconData icon;
  final bool isToggled;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToggled ? null : C.bg3(brightness),
            gradient: isToggled ? G.secondary2 : null,
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: C.accent(brightness),
            ),
          )),
    );
  }
}
