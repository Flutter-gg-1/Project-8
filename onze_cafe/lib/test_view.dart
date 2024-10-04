import 'package:flutter/material.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/supabase/supabase_cart.dart';

import 'supabase/supabase_order.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  void fetchCartItems() {
    SupabasePOrder.fetchPlacedOrder();
  }

  Future upsertItem() async {
    await SupabasePOrder.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          TextButton(onPressed: fetchCartItems, child: Text('Click me')),
          TextButton(onPressed: upsertItem, child: Text('Click me')),
        ],
      )),
    );
  }
}
