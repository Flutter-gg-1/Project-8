import 'package:flutter/material.dart';
import 'package:onze_cafe/models/item_model.dart';

class CartItemCard extends StatelessWidget {
  final Size size;
  final ItemModel item;
  // final CartBloc bloc;
  int quantity;
  CartItemCard(
      {super.key,
      required this.size,
      required this.item,
      required this.quantity,
      // required this.bloc
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xfff0e5d8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.imageUrl,
              width: size.width * 0.25,
              height: size.width * 0.25,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'SAR ${item.price}',
                style: TextStyle(
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffbc793d),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      quantity++;
                    },
                    icon: const Icon(Icons.remove, color: Colors.black),
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) quantity--;
                    },
                    icon: const Icon(Icons.add, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
