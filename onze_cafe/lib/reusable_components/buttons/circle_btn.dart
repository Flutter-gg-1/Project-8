import 'package:flutter/material.dart';

class CircleBtn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Color(0xFFA8483D).withOpacity(1);
    path = Path();
    path.lineTo(size.width, size.height / 2);
    path.cubicTo(size.width, size.height / 2, size.width, size.height,
        size.width, size.height);
    path.cubicTo(size.width, size.height, 0, size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height / 2, 0, size.height / 2);
    path.cubicTo(size.width * 0.13, size.height * 0.19, size.width * 0.31, 0,
        size.width / 2, 0);
    path.cubicTo(size.width * 0.69, 0, size.width * 0.87, size.height * 0.19,
        size.width, size.height / 2);
    path.cubicTo(size.width, size.height / 2, size.width, size.height / 2,
        size.width, size.height / 2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
