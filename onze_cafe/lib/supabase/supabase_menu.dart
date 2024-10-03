import 'dart:io';

import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMenu {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final tableKey = "menu_item";
  static final bucketKey = "menu_items";

  static Future<List<MenuItem>>? fetchMenuItems() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<MenuItem> items = (res as List)
          .map((item) => MenuItem.fromJson(item as Map<String, dynamic>))
          .toList();
      return items;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteItem(MenuItem item) async {
    if (item.id == null) {
      throw ();
    }
    try {
      await supabase.from(tableKey).delete().eq('id', item.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future upsertItem(
      {required File? imageFile, required MenuItem item}) async {
    try {
      if (imageFile != null) {
        item.imgUrl = await uploadImage(imageFile, item.name);
      }
      var response = await supabase.from(tableKey).upsert(
            item.toJson(),
            onConflict: 'name',
          );

      return response;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadImage(File imageFile, String itemName) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName = '$itemName.png';

      // Upload the image, which will automatically overwrite if a file with the same name exists
      await supabase.storage.from(bucketKey).uploadBinary(
            fileName,
            fileBytes,
            fileOptions:
                FileOptions(upsert: true), // Ensure upsert option is enabled
          );

      // Get the public URL for the newly uploaded image
      final publicUrl = supabase.storage.from(bucketKey).getPublicUrl(fileName);

      return publicUrl;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (e) {
      print('Postgrest error: ${e.message}');
      rethrow;
    } catch (e) {
      print('General error: $e');
      rethrow;
    }
  }
}
