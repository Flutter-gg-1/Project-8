import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/widget/inkwell/product_item.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.locator,
    required this.type,
  });

  final ProductLayer locator;
  final String type;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: locator.menu
              .map((e) => e.type == type
                  ? ProductItem(
                      name: e.name!,
                      price: e.price!,
                      id: e.productId,
                      cal: e.cal!,
                      time: e.preparationTime!,
                      description: e.des!,
                      type: e.type!)
                  : const Text(''))
              .toList()),
    );
  }
}
