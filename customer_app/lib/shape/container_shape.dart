import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(15.6577, 40);
    path_0.cubicTo(9.16127, 40, 3.42635, 36.7396, 0, 31.7658);
    path_0.cubicTo(3.26375, 31.3038, 6.28994, 30.1713, 8.67852, 28.4853);
    path_0.cubicTo(11.8666, 26.2348, 13.6577, 23.1826, 13.6577, 20);
    path_0.cubicTo(13.6577, 16.8174, 11.8666, 13.7652, 8.67852, 11.5147);
    path_0.cubicTo(6.28994, 9.82866, 3.26375, 8.69615, 0, 8.23416);
    path_0.cubicTo(3.42636, 3.26041, 9.16128, 0, 15.6577, 0);
    path_0.lineTo(320.658, 0);
    path_0.cubicTo(327.952, 0, 334.287, 4.11089, 337.471, 10.1424);
    path_0.cubicTo(334.834, 10.4884, 332.381, 11.4548, 330.465, 12.9289);
    path_0.cubicTo(328.027, 14.8043, 326.657, 17.3478, 326.657, 20);
    path_0.cubicTo(326.657, 22.6522, 328.027, 25.1957, 330.465, 27.0711);
    path_0.cubicTo(332.381, 28.5452, 334.834, 29.5116, 337.471, 29.8576);
    path_0.cubicTo(334.287, 35.8891, 327.952, 40, 320.658, 40);
    path_0.lineTo(15.6577, 40);
    path_0.close();
    path_0.moveTo(339.657, 21.1377);
    path_0.cubicTo(339.658, 21.0918, 339.658, 21.0459, 339.658, 21);
    path_0.lineTo(339.658, 19);
    path_0.cubicTo(339.658, 18.9541, 339.658, 18.9082, 339.657, 18.8623);
    path_0.lineTo(339.657, 20);
    path_0.lineTo(339.657, 21.1377);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff38232A).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
