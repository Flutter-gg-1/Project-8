import 'package:customer_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/image/logo.png'),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff87B1C5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                  )
                ),
                child: Column(
                  children: [
                    Text('${product.name}')
                  ],
                ),
              ),
            )
            ],
        ),
      ),
    );
  }
}
