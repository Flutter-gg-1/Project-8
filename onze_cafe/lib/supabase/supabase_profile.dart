import 'dart:io';

import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/profile.dart';
import '../utils/img_converter.dart';

class SupabaseProfile {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'profile';
  static final String bucketKey = 'avatar';

  static Future createProfile(Profile profile) async {
    try {
      var response = await supabase.from(tableKey).insert({
        'id': SupabaseMgr.shared.currentUser?.id,
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
      });
      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Profile?> fetchProfile() async {
    try {
      var response = await supabase.from(tableKey).select().single();
      print(response);
      return Profile.fromJson(response);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateProfile(
      {required Profile profile, File? avatarFile}) async {
    try {
      String? avatarUrl;

      if (avatarFile != null) {
        avatarUrl = await uploadAvatar(avatarFile);
      }

      await supabase.from(tableKey).update({
        'name': profile.name,
        'email': profile.email,
        'phone': profile.phone,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      }).eq('id', SupabaseMgr.shared.currentUser!.id);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadAvatar(File imageFile) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName =
          'avatars/${DateTime.now().millisecondsSinceEpoch}.png'; // Use a unique file name

      await supabase.storage.from(bucketKey).uploadBinary(fileName, fileBytes);
      final publicUrl = supabase.storage.from(bucketKey).getPublicUrl(fileName);
      return publicUrl;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
