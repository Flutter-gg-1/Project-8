import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/setup.dart';

class CoffeeCard extends StatelessWidget {
  final Size size;
  final String? imageUrl;
  final String name;
  final double price;
  final int rating;

  const CoffeeCard({
    super.key,
    required this.size,
    required this.name,
    required this.price,
    this.imageUrl,
    required this.rating, // Required rating field
  });

  // Function to build stars based on the rating value
  Widget buildRatingStars(int rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(Icon(
        i <= rating ? Icons.star : Icons.star_border, // Filled or empty star
        color: Colors.yellow,
        size: size.width * 0.04, // Adjust star size
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
      width: size.width * 0.28, // Smaller width for the container
      height: size.height * 0.18, // Adjusted height for the container
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF), // Slightly lighter dark grey
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xff87B1C5)), // Rounded corners
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
            // Center the text horizontally
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.07, // Adjust the top padding
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center, // Center text
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    '$price SAR', // Display the product price
                    style: TextStyle(
                      fontSize:
                          size.width * 0.032, // Adjusted font size for price
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Text color
                    ),
                    textAlign: TextAlign.center, // Center text
                  ),
                  const SizedBox(height: 5),
                  // Display rating stars
                  buildRatingStars(rating),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.08, // Adjusted position for the button
            right: -size.width * 0.02, // Adjusted position for the button
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
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
