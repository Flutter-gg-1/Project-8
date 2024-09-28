import 'dart:developer';

import 'package:customer_app/DB/super.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/services/setup.dart';

mixin OrderMix on Super {
  final locator = productLocator.get<ProductLayer>();
  Future<void> getMenu() async {
    try {
      final x = await supabase.from('product').select('*');
      for (var product in x) {
        locator.menu.add(Product.fromJson(product));
      }
    } catch (e) {
      log('$e');
    }
  }
}
