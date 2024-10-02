import 'package:employee_app/models/user_model.dart';
import 'package:employee_app/screens/home_screen.dart';
import 'package:employee_app/screens/order/order_screen.dart';
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
        appBarTheme: const AppBarTheme(
         backgroundColor:   Color(0xffD7D1CA)
        )),
      debugShowCheckedModeBanner: false,
      home: OrderScreen(
          user: UserModel(
              customerId: '123456',
              email: 'email@gmail.com',
              firstName: 'Base',
              lastName: 'Alalawi')),
    );
  }
}
