import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  static Future createAccount(String email, String password) async {
    try {
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);

      // Update current user
      SupabaseMgr.shared.setCurrentUser();

      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future verifyOtp({required String email, required String otp}) async {
    try {
      await supabase.auth
          .verifyOTP(email: email, type: OtpType.signup, token: otp);

      // Update current user
      await SupabaseMgr.shared.setCurrentUser();

      // Subscribe to notifications
      var userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        OneSignal.login(userId);
      }
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future signIn(String email, String password) async {
    try {
      final AuthResponse response = await supabase.auth
          .signInWithPassword(email: email, password: password);

      // Update current user
      await SupabaseMgr.shared.setCurrentUser();

      // Subscribe to notifications
      var userId = supabase.auth.currentUser?.id;
      if (userId != null) {
        OneSignal.login(userId);
      }

      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future anonymousSignIn() async {
    try {
      final AuthResponse response = await supabase.auth.signInAnonymously();
      // Update current user
      await SupabaseMgr.shared.setCurrentUser();
      SupabaseMgr.shared.currentProfile = null;
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future signOut() async {
    try {
      var response = await supabase.auth.signOut();
      // Un-Subscribe to notifications
      OneSignal.logout();
      // Update current user
      SupabaseMgr.shared.currentUser = null;
      SupabaseMgr.shared.currentProfile = null;

      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
