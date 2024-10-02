import 'package:supabase_flutter/supabase_flutter.dart';

abstract class Super {
  final supabase = Supabase.instance.client;
}
