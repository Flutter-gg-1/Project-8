import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/circle_btn.dart';

class CustomCircleBtn extends StatelessWidget {
  const CustomCircleBtn({
    super.key,
    required this.brightness,
    required this.onTap,
    required this.title,
    this.subTitle,
  });

  final Brightness brightness;
  final Function()? onTap;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomPaint(
                    size: Size(
                        0, 90), // Specify the size for your custom painting
                    painter: CircleBtn()),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*  
              TODOs Total price after add more than one cup for item details screen 
             */
              Text(title).styled(
                  size: 18, color: C.bg1(brightness), weight: FontWeight.bold),
              Text(subTitle ?? '').styled(
                  size: 18, color: C.bg1(brightness), weight: FontWeight.bold),
            ],
          )
        ],
      ),
    );
  }
}
