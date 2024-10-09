import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/coulmn/item_list.dart';
import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locator = productLocator.get<ProductLayer>();
    return TabBarView(children: [
      //Classic Coffee menu
      ItemList(
        locator: locator,
        type: 'Classic_Coffee',
      ),
      //Tea menu
      ItemList(
        locator: locator,
        type: 'Tea',
      ),
      //Cold drinks menu
      ItemList(
        locator: locator,
        type: 'Cold_drinks',
      ),
      //drip coffee menu
      ItemList(
        locator: locator,
        type: 'drip_coffee',
      ),
      //water menu
      ItemList(
        locator: locator,
        type: 'water',
      ),
      //Focaccia menu
      ItemList(
        locator: locator,
        type: 'Focaccia',
      ),
      //croissant menu
      ItemList(
        locator: locator,
        type: 'croissant',
      ),
      //cookies menu
      ItemList(
        locator: locator,
        type: 'cookies',
      ),
      //fennel cake menu
      ItemList(
        locator: locator,
        type: 'fennel',
      ),
      //dessert menu
      ItemList(
        locator: locator,
        type: 'dessert',
      ),
    ]);
  }
}
