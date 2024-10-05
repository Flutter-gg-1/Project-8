import 'package:flutter/cupertino.dart';

extension G on Gradient {
  static const primary = LinearGradient(
      colors: [Color(0xFF648997), Color(0xFF3D6B7D)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const accent = LinearGradient(
      colors: [Color(0xFF98B7C6), Color(0xFFB5C3CB)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const secondary = LinearGradient(
      colors: [Color(0xFFA8483D), Color(0xFFCB928B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const secondary2 = LinearGradient(
      colors: [Color(0xFFA8483D), Color(0xFFCB928B)],
      begin: Alignment.topRight,
      end: Alignment.bottomRight);
  static const secondary3 = LinearGradient(colors: [
    Color(0xFFA8483D),
    Color(0xFFBC6459),
  ], begin: Alignment.bottomCenter, end: Alignment.topCenter);
}
