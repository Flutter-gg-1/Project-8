import 'dart:io';

import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategory {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'menu_category';
  static final String bucketKey = 'categories';

  Future createCategory(MenuCategory category) async {
    try {
      await supabase.from(tableKey).insert({
        "name": category.name,
        "description": category.description,
        "img_url": category.imgUrl,
        "sort_priority": category.sortPriority,
      });
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteCategory(MenuCategory category) async {
    if (category.id == null) {
      print("Category ID is null. Cannot delete.");
      throw ();
    }
    try {
      await supabase
          .from(tableKey)
          .delete()
          .eq('id', category.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateCategory(MenuCategory category, File imageFile) async {
    String imageUrl;
    try {
      await supabase.from(tableKey).update({
        "name": category.name,
        "description": category.description,
        "img_url": category.imgUrl,
        "sort_priority": category.sortPriority,
      });
    } on AuthException catch (_) {
    } on PostgrestException catch (_) {
    } catch (e) {}
  }

  static Future fetchCategory(MenuCategory category) async {
    try {
      var res = await supabase
          .from(tableKey)
          .select('id, name , description, img_url,sort_priority');
      print(res);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName =
          'menu_categories/${DateTime.now().millisecondsSinceEpoch}.png'; // Use a unique file name

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
