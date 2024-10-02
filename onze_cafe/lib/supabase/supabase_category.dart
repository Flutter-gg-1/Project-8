import 'dart:io';

import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCategory {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final String tableKey = 'menu_category';
  static final String bucketKey = 'categories';

  static Future<List<MenuCategory>>? fetchCategories() async {
    try {
      var res = await supabase.from(tableKey).select();
      List<MenuCategory> categories = (res as List)
          .map((item) => MenuCategory.fromJson(item as Map<String, dynamic>))
          .toList();
      return categories;
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future upsertCategory(
      {required File? imageFile, required MenuCategory category}) async {
    try {
      if (imageFile != null) {
        category.imgUrl = await uploadImage(imageFile, category.name);
      }
      var response = await supabase.from(tableKey).upsert(
            category.toJson(),
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

  static Future deleteCategory(MenuCategory category) async {
    if (category.id == null) {
      throw Exception('Could not find records of this category');
    }
    try {
      await supabase.from(tableKey).delete().eq('id', category.id!);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String?> uploadImage(File imageFile, String catName) async {
    try {
      final fileBytes = await ImgConverter.fileImgToBytes(imageFile);
      final fileName = '$catName.png';

      // Remove existing image if it exists
      await SupabaseMgr.shared.supabase.storage
          .from('categories')
          .remove([fileName]);

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
