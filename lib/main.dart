import 'package:flutter/material.dart';
import 'package:onze_cafe/Auth%20Screens/login_screen.dart';
import 'package:onze_cafe/Auth%20Screens/register_screen.dart';
import 'package:onze_cafe/Home%20Screen/home_screen.dart';
import 'package:onze_cafe/services/setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RegisterScreen());
  }
}
