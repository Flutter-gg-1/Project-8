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
            userId: '017c065f-3970-411f-a1e9-68cde68856e4',
            menuItemId: '128c1da9-bc73-4a92-8b4d-631d22577201'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: TextButton(onPressed: upsertItem, child: Text('Click me'))),
    );
  }
}
