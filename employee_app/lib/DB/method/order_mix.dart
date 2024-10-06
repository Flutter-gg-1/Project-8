import 'dart:developer';

import 'package:employee_app/DB/super.dart';
import 'package:employee_app/data_layer/auth_layer.dart';
import 'package:employee_app/data_layer/product_layer.dart';
import 'package:employee_app/models/product_model.dart';
import 'package:employee_app/services/setup.dart';

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

  getUserOrderHistory() async {
    try {
      final user = authLocator.get<AuthLayer>().user;

      final res = await supabase
          .from("orders")
          .select()
          .eq("customer_id", user!.customerId);

      return res;
    } catch (er) {
      log("err in getUserOrderHistory ");
      log("$er");
    }
  }

  getAllUserOrder({required String orderId}) async {
    try {
      final res =
          await supabase.from("order_detail").select().eq("order_id", orderId);

      return res;
    } catch (er) {
      log("err in  getAllUserOrder");
      log("$er");
    }
  }

  getCustumersOrders() async {
    try {
      final res = await supabase
          .from("orders")
          .select()
          .not("status", "in", ["Cancelled", "delivered"]);

      return res;
    } catch (er) {
      log("$er");
      throw Exception;
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

  orderChangeStatus({required String status, required String orderId}) async {
    try {
      await supabase
          .from("orders")
          .update({"status": status}).eq("order_id", orderId);
    } catch (er) {
      log("$er");
      throw Exception;
    }
  }
}
