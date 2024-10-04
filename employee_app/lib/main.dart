import 'package:employee_app/DB/super_main.dart';
import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/screens/home_screen.dart';
import 'package:employee_app/screens/menu/menu_screen.dart';
import 'package:employee_app/screens/order/order_screen.dart';
import 'package:employee_app/screens/order/order_status.dart';
import 'package:employee_app/services/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await setup();
  final test = SuperMain();
  await test.getMenu();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffD7D1CA),
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xffD7D1CA))),
        debugShowCheckedModeBanner: false,
        home: HomeScreen());
  }
}
