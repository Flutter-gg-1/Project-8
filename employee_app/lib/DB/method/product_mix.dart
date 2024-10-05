import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:uuid/uuid.dart';

import 'package:employee_app/DB/super.dart';
import 'package:employee_app/DB/super_main.dart';

mixin ProductMix on Super {
  delItem({required String productId}) async {
    try {
      final res = await supabase
          .from("product")
          .delete()
          .eq("product_id", productId)
          .select();

      print(res);
    } catch (er) {
      log("$er");
      throw Exception;
    }
  }

  getProductById({required String productId}) async {
    try {
      final res = await supabase
          .from("product")
          .select()
          .eq("product_id", productId)
          .single();

      return res;
    } catch (er) {
      log("$er");
    }
  }

  Future<void> updateItemDb({
    required String id, // Add an id parameter to identify the item
    required String name,
    required String cal,
    required double price,
    required int time,
    required String type,
    String? des,
    File? img,
  }) async {
    try {
      String? imgRes;

      if (img != null) {
        imgRes = await SuperMain()
            .supabase
            .storage
            .from("product_img")
            .upload("path/${const Uuid().v4()}", img);
      }

      final res = await SuperMain().supabase.from("product").update({
        "name": name,
        "cal": cal,
        "price": price,
        "type": type,
        "preparation_time": time,
        "des": des,
        "img_path": imgRes
      }).eq("product_id", id);

      print(res);
    } catch (er) {
      log("$er");
      throw Exception;
    }
  }

  addItemDb(
      {required String name,
      required String cal,
      required double price,
      required int time,
      required String type,
      String? des,
      File? img}) async {
    try {
      String? imgRes;

      if (img != null) {
        imgRes = await SuperMain()
            .supabase
            .storage
            .from("product_img")
            .upload("path/${const Uuid().v4()}", img);
      }

      final res = await SuperMain().supabase.from("product").insert({
        "name": name,
        "cal": cal,
        "price": price,
        "type": type,
        "preparation_time": time,
        "des": des,
        "img_path": imgRes
      });
    } catch (er) {
      log("$er");

      throw Exception;
    }
  }
}
