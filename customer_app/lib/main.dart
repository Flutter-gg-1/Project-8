import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/screens/auth/login_screen.dart';
import 'package:customer_app/screens/first_screen.dart';
import 'package:customer_app/screens/home_screen.dart';
import 'package:customer_app/services/setup.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffD7D1CA),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xffD7D1CA))),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
