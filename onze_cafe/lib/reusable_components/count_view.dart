import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountView extends StatelessWidget {
  const CountView({
    super.key,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
    required this.iconSize,
    required this.iconColor,
    required this.fSize,
    required this.fColor,
  });

  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color iconColor;
  final double iconSize;
  final Color fColor;
  final double fSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: Icon(
            CupertinoIcons.minus_square,
            size: iconSize,
            color: iconColor,
          ),
        ),
        Text("$count", style: TextStyle(fontSize: fSize, color: fColor)),
        IconButton(
            onPressed: onIncrement,
            icon: Icon(
              CupertinoIcons.plus_square,
              size: iconSize,
              color: iconColor,
            )),
      ],
    );
  }
}
