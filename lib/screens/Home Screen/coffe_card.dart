import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/order_item_model.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_bloc/home_bloc.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_screen.dart';
import 'package:onze_cafe/services/setup.dart';

class CoffeeCard extends StatelessWidget {
  final Size size;
  final String? imageUrl;
  final String name;
  final double price;
  final int rating;
  final int itemId;
  final HomeBloc bloc;

  const CoffeeCard(
      {super.key,
      required this.size,
      required this.name,
      required this.price,
      this.imageUrl,
      required this.rating,
      required this.itemId,
      required this.bloc});

  Widget buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(Icon(
        i <= rating ? Icons.star : Icons.star_border,
        color: Colors.yellow,
        size: size.width * 0.04,
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: stars,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.28,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xff87B1C5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -size.height * 0.07,
            left: -size.width * 0.06,
            child: ClipOval(
              clipBehavior: Clip.none,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: size.width * 0.55,
                      height: size.height * 0.2,
                      fit: BoxFit.contain,
                    )
                  : Image.asset(
                      'assets/coffe_of_thday.png',
                      color: Colors.grey,
                    ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.07,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '$price SAR',
                    style: TextStyle(
                      fontSize: size.width * 0.032,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  // Display rating stars
                  buildRatingStars(rating),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.13,
            right: -size.width * 0.02,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  locator.get<DataLayer>().addItem(
                        item: OrderItemModel(
                          itemId: itemId,
                          quantity: 1,
                          price: price,
                          orderId: locator.get<DataLayer>().order!.orderId,
                        ),
                      );
                  log('Added item to cart: $name');
                  bloc.add(UpdateCartCountEvent(
                      count: locator.get<DataLayer>().cart.items.length));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$name added to cart'),
                      duration: const Duration(milliseconds: 650),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Color(0xffA8483D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
