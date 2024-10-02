import 'dart:io';

import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';
import 'package:onze_cafe/utils/img_converter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseMenu {
  static final SupabaseClient supabase = SupabaseMgr.shared.supabase;
  static final tableKey = "menu_item";
  static final bucketKey = "menu_items";

  static Future createItem(MenuItem item) async {
    try {
      await supabase.from(tableKey).insert({
        "id": item.id,
        "categoryId": "fdc2e822-3d67-47ca-8ea8-8513ab8e6767",
        "name": item.name,
        "calories": item.calories,
        "imgUrl": item.imgUrl,
        "description": item.description,
        "price": item.price,
        "oz": item.oz,
      });
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
      await supabase.from(tableKey).delete().eq('id', item.id);
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future updateItems(MenuItem item, File imageFile) async {
    try {
      await supabase.from(tableKey).update({
        "id": item.id,
        "categoryId": "fdc2e822-3d67-47ca-8ea8-8513ab8e6767",
        "name": item.name,
        "calories": item.calories,
        "imgUrl": item.imgUrl,
        "description": item.description,
        "price": item.price,
        "oz": item.oz,
      });
    } on AuthException catch (_) {
      rethrow;
    } on PostgrestException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  static Future fetchItems(MenuItem item) async {
    try {
      await supabase.from(tableKey).select().single();
      var res = await supabase.from(tableKey).select();
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
