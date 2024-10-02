import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() onPressed;
  final Size? fixedSize;
  final Color? titleColor;
  const CustomButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
    this.fixedSize,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: fixedSize ??
              Size(context.getWidth(multiply: 0.6),
                  context.getHeight(multiply: 0.06)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
          backgroundColor: const Color(0xffA8483D),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            const Spacer(),
            Text(
              title,
              style: TextStyle(fontSize: 18, color: titleColor ?? Colors.white),
            ),
            const Spacer(),
            Icon(
              icon,
              color: Colors.white,
            )
          ],
        ));
  }
}
