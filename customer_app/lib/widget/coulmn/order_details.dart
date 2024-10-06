import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${product.des}',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rosarivo',
                color: Color(0x60000000)),
          ),
          const Divider(),
          context.addSpacer(multiply: 0.02),
          Text(
            'Cal : ${product.cal}',
            style: const TextStyle(
                fontSize: 20,
                color: Color(0xffA8483D),
                fontWeight: FontWeight.bold,
                fontFamily: 'Rosarivo'),
          ),
          context.addSpacer(multiply: 0.02),
          Text(
            'preparation Time : ${product.preparationTime}',
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xffA8483D),
              fontWeight: FontWeight.bold,
            ),
          ),
          context.addSpacer(multiply: 0.02),
          Text(
            'Price : ${product.price} RS',
            style: const TextStyle(
                fontSize: 20,
                color: Color(0xffA8483D),
                fontWeight: FontWeight.bold,
                fontFamily: 'Rosarivo'),
          ),
          context.addSpacer(multiply: 0.02),
        ],
      ),
    );
  }
}
