import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/screens/order/order_info.dart';
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
    final filteredItems = locator.menu
        .where((e) =>
            e.type?.trim() == type.trim() && e.name != null && e.price != null)
        .toList();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final e = filteredItems[index];
        return ProductItem(
          name: e.name!,
          price: e.price!,
          id: e.productId,
          cal: e.cal!,
          time: e.preparationTime!,
          description: e.des!,
          type: e.type!,
          imgPath: e.imgPath,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderInfo(product: e),
            ),
          ),
        );
      },
    );
  }
}
