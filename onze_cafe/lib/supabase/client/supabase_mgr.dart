import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/profile.dart';

class SupabaseMgr {
  late final SupabaseClient supabase;
  User? currentUser;
  Profile? currentProfile;

  SupabaseMgr._privateConstructor();

  static final SupabaseMgr _instance = SupabaseMgr._privateConstructor();

  static SupabaseMgr get shared => _instance;

  Future setCurrentUser() async {
    try {
      currentUser = supabase.auth.currentUser;
      if (currentUser != null) {
        currentProfile =
            await SupabaseProfile.fetchProfile(currentUser?.id ?? '');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in setCurrentUser: $e');
      }
    }
  }

  // Initialize method to configure the Supabase client asynchronously
  Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
    supabase = await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    ).then((value) => value.client);

    // Store the current user after initialization
    currentUser = supabase.auth.currentUser;
  }
}
