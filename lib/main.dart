import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onze_coffee_app/screen/auth/otp_screen.dart';
import 'package:onze_coffee_app/screen/auth/register_screen.dart';
import 'package:onze_coffee_app/screen/employee/admin_nav.dart';
import 'package:onze_coffee_app/screen/user/nav_bar/user_nav.dart';
import 'package:onze_coffee_app/screen/user/user_home_screen.dart';

import 'package:onze_coffee_app/services/init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screen/auth/login_screen.dart';
import 'integrations/supabase/supabase_client.dart';

void main() async {
  // To initialize Flutter's
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from the .env file
  await dotenv.load();
  // Initialize Supabase
  supabase = await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );
  setup();

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const MainApp(), // Wrap your app
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
