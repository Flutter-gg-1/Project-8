import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/supabase/supabase_profile.dart';
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
      if (currentProfile != null) {
        if (currentProfile!.role == 'employee') {
          await OneSignal.User.addTagWithKey("role", "employee");
        } else {
          await OneSignal.User.addTagWithKey("role", "customer");
          currentProfile!.externalId = await OneSignal.User.getExternalId();
          await SupabaseProfile.updateProfile(profile: currentProfile!);
        }
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
