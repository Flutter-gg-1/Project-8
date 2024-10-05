
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

class CustomeContainer extends StatelessWidget {
  const CustomeContainer({
    super.key,
    required this.brightness,
    required this.title,
    required this.icon,
    required this.number,
  });

  final Brightness brightness;
  final String title;
  final String number;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 24, bottom: 8),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              offset: Offset.zero,
              color: C.secondary(brightness).withOpacity(0.7),
              blurRadius: 4,
            )
          ], color: C.bg3(brightness), borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.all(8),
                  child: Icon(
                    icon,
                    color: C.secondary(brightness),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(number).styled(
                    size: 24,
                    color: C.secondary(brightness),
                    weight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Text(title).styled(),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
