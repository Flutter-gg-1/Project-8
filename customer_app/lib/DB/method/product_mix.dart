import 'package:customer_app/DB/super.dart';

mixin ProductMix on Super {
  getProductById({required String productId}) async {
    try {
      final res = await supabase
          .from("product")
          .select()
          .eq("product_id", productId)
          .single();

      return res;
    } catch (er) {
      rethrow;
    }
  }
}
