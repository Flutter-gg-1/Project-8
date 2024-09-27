import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/cart_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details Screen'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [],
            ),
          ),
          TextButton(onPressed: () => (), child: const Text('Add to Cart'))
        ],
      )),
    );
  }
}
