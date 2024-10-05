import 'dart:math';

import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';

class ProfileMostOrderWidget extends StatelessWidget {
  const ProfileMostOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> menu = productLocator.get<ProductLayer>().menu;
    int mostOrder = Random().nextInt(menu.length);
    return Container(
      width: 250,
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xffA8483D),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Image.asset("assets/image/coffee cup-amico 1.png"),
          const SizedBox(
            width: 10,
          ),
          Text(
            menu[mostOrder].name != null
                ? "${menu[mostOrder].type}\n${menu[mostOrder].name!.length <= 12 ? menu[mostOrder].name : '${menu[mostOrder].name!.substring(0, 12)}..'}"
                : '',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
