import 'dart:developer';

import 'package:customer_app/DB/super.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/services/setup.dart';

mixin OrderMix on Super {
  final locator = productLocator.get<ProductLayer>();
  Future<void> getMenu() async {
    try {
      final x = await supabase.from('product').select('*');
      for (var product in x) {
        locator.menu.add(ProductModel.fromJson(product));
      }
    } catch (e) {
      log('$e');
    }
  }

  getUserOrder({String? status}) async {
    try {
      final user = authLocator.get<AuthLayer>().user;

      if (status != null) {
        final res = await supabase
            .from("orders")
            .select()
            .eq("customer_id", user!.customerId)
            .eq("status", status);
        return res;
      } else {
        final res = await supabase
            .from("orders")
            .select()
            .eq("customer_id", user!.customerId)
            .not("status", "in", ["Cancelled","delivered"]);
        return res;
      }
    } catch (er) {
      log("err in getUserOrder ");
      log("$er");
    }
  }

  getAllUserOrderDetail({required String orderId}) async {
    try {
      final res =
          await supabase.from("order_detail").select().eq("order_id", orderId);

      return res;
    } catch (er) {
      log("err in  getAllUserOrder");
      log("$er");
    }
  }
}
