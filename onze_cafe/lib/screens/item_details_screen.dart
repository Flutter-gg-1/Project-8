import 'package:flutter/material.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/cart_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Text(item.name),
                Text('${item.price}'),
              ],
            ),
          ),
          TextButton(onPressed: () => (), child: const Text('Add to Cart'))
        ],
      )),
    );
  }
}
