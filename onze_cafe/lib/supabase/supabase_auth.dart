import 'package:onze_cafe/supabase/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuth {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;

  static Future createAccount(String email, String password) async {
    try {
      final AuthResponse response =
          await supabase.auth.signUp(email: email, password: password);
      return response;
    } on AuthException catch (e) {
      rethrow;
    } on PostgrestException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future verifyOtp({required String email, required String otp}) async {
    try {
      final user = await supabase.auth
          .verifyOTP(email: email, type: OtpType.signup, token: otp);
      await supabase
          .from("profile")
          .insert({"id": user.user?.id, "email": email});
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
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  // static Future signInWithOtp(String email) async {
  //   try {
  //     await supabase.auth.signInWithOtp(email: email);
  //   } on AuthException catch (_) {
  //     rethrow;
  //   } on PostgrestException catch (_) {
  //     rethrow;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
