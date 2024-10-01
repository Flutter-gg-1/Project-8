import 'package:flutter/cupertino.dart';

extension G on Gradient {
  static const primary = LinearGradient(
      colors: [Color(0xFF648997), Color(0xFF3D6B7D)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const accent = LinearGradient(
      colors: [Color(0xFFEDECEB), Color(0xFFD8E1E6)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const secondary = LinearGradient(
      colors: [Color(0xFFA8483D), Color(0xFFCB928B)],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft);
}
