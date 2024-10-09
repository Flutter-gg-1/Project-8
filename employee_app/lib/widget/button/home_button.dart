import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeButtonEmp extends StatelessWidget {
  const HomeButtonEmp({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    required this.color,
    required this.text,
    required this.textSize,
    required this.isIcon,
  });
  final Function()? onTap;
  final double width;
  final double height;
  final Color color;
  final bool isIcon;
  final String text;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                image: const DecorationImage(
                  image:
                      AssetImage('assets/image/coffee_background_button.png'),
                  fit: BoxFit.cover,
                ),
                color: color,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isIcon
                    ? Icon(EvaIcons.file_text,
                        size: context.getHeight(multiply: 0.07),
                        color: const Color(0xffA8483D))
                    : Image.asset('assets/image/coffee_img.png'),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: textSize,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        isIcon
            ? Positioned(
                right: context.getWidth(multiply: 0.3),
                top: 0,
                child: Container(
                  width: context.getWidth(multiply: 0.05),
                  height: context.getHeight(multiply: 0.06),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.transparent),
                  child: const Center(
                    child: Text(
                      '',
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ))
            : const Text('')
      ],
    );
  }
}
