import 'package:flutter/material.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/screens/cart_screen/cart_bloc/cart_bloc.dart';

class CartItemCard extends StatelessWidget {
  final Size size;
  final ItemModel item;
  final CartBloc bloc;
  final OrderItemModel orderItem;
  int quantity;

  CartItemCard({
    super.key,
    required this.size,
    required this.item,
    required this.quantity,
    required this.bloc,
    required this.orderItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: size.width * 0.035,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow
                      .ellipsis,
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
                        if (quantity > 1) {
                          bloc.add(
                              CartUpdateQuantityEvent(orderItem, quantity - 1));
                        }
                      },
                      icon: const Icon(Icons.remove, color: Colors.black),
                    ),
                    Text(
                      '${orderItem.quantity}',
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        bloc.add(
                            CartUpdateQuantityEvent(orderItem, quantity + 1));
                      },
                      icon: const Icon(Icons.add, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              bloc.add(CartDeleteItemEvent(orderItem));
            },
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
