import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/cart_screen.dart';

import 'item_details_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void navigateToCart(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const CartScreen()));

  void navigateToItemDetails(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ItemDetailsScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => navigateToCart(context),
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                TextButton(
                    onPressed: () => navigateToItemDetails(context),
                    child: const Text('Navigate to Item Details'))
              ],
            ),
          )
        ],
      )),
    );
  }
}
