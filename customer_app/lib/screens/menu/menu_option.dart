import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/inkwell/product_item.dart';
import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locator = productLocator.get<ProductLayer>();
    return TabBarView(children: [
      //cold coffee menu
      ItemList(locator: locator,type: '',),
      //Tea menu
      Text('2'),
      //Cold drinks menu
      Text('3'),
      //drip coffee menu
      Text('4'),
      //water menu
      Text('5'),
      //Focaccia menu
      Text('6'),
      //croissant menu
      Text('7'),
      //cookies menu
      Text('8'),
      //fennel cake menu
      Text('9'),
      //dessert menu
      Text('10'),
    ]);
  }
}

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.locator, required this.type,
  });

  final ProductLayer locator;
  final String type;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          children: locator.menu
              .map(
                (e) =>e.type == ''? ProductItem(
                    name: e.name!,
                    price: e.price!,
                    id: e.productId,
                    cal: e.cal!,
                    time: e.preparationTime!,
                    description: e.des!,
                    type: e.type!): Text('')
              )
              .toList()),
    );
  }
}
