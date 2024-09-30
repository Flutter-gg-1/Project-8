import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/setup.dart';

class CoffeeCard extends StatelessWidget {
  final Size size;
  final String? imageUrl;
  final String name;
  final double price;

  const CoffeeCard({
    super.key,
    required this.size,
    required this.name,
    required this.price,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.28, // Smaller width for the container
      height: size.height * 0.13, // Smaller height for the container
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF), // Slightly lighter dark grey
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color(0xff87B1C5)), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -size.height * 0.015,
            left: -size.width * 0.06,
            child: ClipOval(
              clipBehavior: Clip.none,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      width: size.width * 0.55,
                      height: size.height * 0.09,
                      fit: BoxFit.contain,
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 80,
                      color: Colors.grey,
                    ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.05,
              bottom: size.height * 0.01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center content
              children: [
                Text(
                  name, // Display the product name
                  style: TextStyle(
                    fontSize: size.width * 0.03, // Adjusted font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
                SizedBox(height: size.height * 0.004), // Reduced spacing
                Text(
                  '$price SAR', // Display the product price
                  style: TextStyle(
                    fontSize:
                        size.width * 0.032, // Adjusted font size for price
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.08, // Adjusted position for the button
            right: -size.width * 0.02, // Adjusted position for the button
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  // add item to datalayer list
                  // add to cart

                  //  locator.get<DataLayer>().addItem(item: item);
                  
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Color(0xffA8483D), // Icon color
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
