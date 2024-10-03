import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/container/custom_container.dart';

class ReportsDashBoardView extends StatelessWidget {
  const ReportsDashBoardView({
    super.key,
    required this.brightness,
  });

  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reports Dashboard").styled(
            weight: FontWeight.bold, size: 22, color: C.primary(brightness)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomeContainer(
              brightness: brightness,
              title: "Customer",
              icon: Icons.people_alt_rounded,
              number: '134',
            ),
            CustomeContainer(
              brightness: brightness,
              title: "Menu items",
              icon: Icons.food_bank_rounded,
              number: '20',
            ),
            CustomeContainer(
              brightness: brightness,
              title: "sales",
              icon: Icons.monetization_on,
              number: '300',
            )
          ],
        )
      ],
    );
  }
}
