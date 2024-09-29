import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/landing_screen.dart';
import 'package:onze_cafe/screens/menu/menu_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: const MenuScreen());
  }
}
