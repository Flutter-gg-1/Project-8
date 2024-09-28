import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
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
                      type: e.type!,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.getWidth(multiply: 0.1),
                              vertical: context.getWidth(multiply: 0.05)),
                            height: context.getHeight(multiply: 0.5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xff87B1C5),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Image.asset('assets/image/logo_small.png'),
                                Divider(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Text(
                                        e.name!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            fontFamily: 'Rosarivo'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : const Text(''))
              .toList()),
    );
  }
}
