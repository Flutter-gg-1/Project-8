import 'package:flutter/material.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/supabase/supabase_cart.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});

  void fetchCartItems() {
    SupabaseCart.fetchCart();
  }

  Future upsertItem() async {
    await SupabaseCart.upsertCartItem(
        cartItem: CartItem(
            userId: '99163a2e-fdd7-4ee8-aa14-6df8710c01da',
            menuItemId: '9aef7e54-eef3-4f96-94dd-94a318cddf52'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: TextButton(onPressed: upsertItem, child: Text('Click me'))),
    );
  }
}
