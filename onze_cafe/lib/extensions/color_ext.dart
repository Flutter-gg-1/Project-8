import 'package:flutter/material.dart';

extension C on Colors {
  // Primary color based on the current brightness
  static Color primary(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF3D6B7D) // Dark theme primary color
        : const Color(0xFF3D6B7D); // Light theme primary color
  }

  // Secondary color based on the current brightness
  static Color secondary(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFA8483D) // Dark theme secondary color
        : const Color(0xFFA8483D); // Light theme secondary color
  }

  static Color accent(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF87B1C5) // Dark theme text color
        : const Color(0xFF87B1C5); // Light theme text color
  }

  // Background color 1 based on the current brightness
  static Color bg1(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFEDECEB) // Dark theme background
        : const Color(0xFFD7D1CA); // Light theme background
  }

  // Background color 2 based on the current brightness
  static Color bg2(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFD7D1CA) // Dark theme background 2
        : const Color(0xFFEDECEB); // Light theme background 2
  }

  // Background color 3 based on the current brightness
  static Color bg3(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFE7E3E0) // Dark theme background 3
        : const Color(0xFFE7E3E0); // Light theme background 3
  }

  // primary color 2 based on the current brightness
  static Color primary2(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFD8E1E6) // Dark theme background 3
        : const Color(0xFFD8E1E6); // Light theme background 3
  }

  // primary color 2 based on the current brightness
  static Color secondary2(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFFEDDAD8) // Dark theme background 3
        : const Color(0xFFEDDAD8); // Light theme background 3
  }

  // Text color based on the current brightness
  static Color text(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0xFF3A3A3A) // Dark theme text color
        : const Color(0xFF3A3A3A); // Light theme text color
  }
}
