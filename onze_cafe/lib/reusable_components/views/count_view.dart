import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountView extends StatelessWidget {
  const CountView({
    super.key,
    required this.color,
    required this.size,
    required this.count,
    this.onIncrement,
    this.onDecrement, 
    required this.fSize,
  });

  final Color color;
  final double size;
  final double fSize;
  final int count;
  final Function()? onIncrement;
  final Function()? onDecrement;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onDecrement,
          icon: Icon(
            CupertinoIcons.minus_rectangle,
            size: size,
            color: color,
          ),
        ),
        Text("$count", style: TextStyle(fontSize: fSize, color: color)),
        IconButton(
            onPressed: onIncrement,
            icon: Icon(
              CupertinoIcons.plus_rectangle,
              size: size,
              color: color,
            )),
      ],
    );
  }
}
