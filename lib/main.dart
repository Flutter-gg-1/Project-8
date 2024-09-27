import 'package:flutter/material.dart';
import 'package:onze_cafe/Auth%20Screens/auth_screan.dart';
import 'package:onze_cafe/Home%20Screen/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen()
    );
  }
}
