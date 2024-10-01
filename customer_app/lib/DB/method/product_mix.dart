import 'dart:developer';

import 'package:customer_app/DB/super.dart';

mixin ProductMix on Super {
  getProducById({required String producId}) async {
    try {
      final res = await superbase
          .from("product")
          .select()
          .eq("product_id", producId)
          .single();

      return res;
    } catch (er) {
      log("$er");
    }
  }
}
