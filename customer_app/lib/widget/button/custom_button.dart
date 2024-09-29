import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.title,
    this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(context.getWidth(multiply: 0.6),
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
              style: const TextStyle(fontSize: 18, color: Colors.white),
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