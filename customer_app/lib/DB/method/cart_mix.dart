import 'package:customer_app/DB/super.dart';
import 'package:customer_app/models/order_details_model.dart';

mixin CartMix on Super {
  insetCartData(
      {required String orderId,
      required List<OrderDetailsModel> cartList}) async {
    try {
      for (var val in cartList) {
        final res = await supabase.from("order_detail").insert({
          "quantity": val.quantity,
          "order_id": orderId,
          "product_id": val.productId,
          "size": val.size,
        }).select();
      }
    } catch (er) {
      rethrow;
    }
  }

  placeOrder(
      {required String customerId,
      required double totalPrice,
      required int totalPreTime}) async {
    try {
      final res = await supabase.from("orders").insert({
        "customer_id": customerId,
        "total_price": totalPrice,
        "time": DateTime.now().toIso8601String(),
        "total_preparation_time": totalPreTime,
        "status": "Pending"
      }).select();

      return res[0]["order_id"];
    } catch (er) {
      rethrow;
    }
  }
}
