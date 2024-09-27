import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/widget/inkwell/product_item.dart';
import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  const MenuOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const TabBarView(children: [
      //cold coffee menu
      SingleChildScrollView(
        child: Column(
          children: [
            ProductItem(
              name: 'Latte',
              price: '15',
            ),
            ProductItem(
              name: 'Latte',
              price: '15',
            ),
            ProductItem(
              name: 'Latte',
              price: '15',
            ),
            ProductItem(
              name: 'Latte',
              price: '15',
            ),
          ],
        ),
      ),
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
