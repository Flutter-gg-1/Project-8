import 'dart:developer';
import 'package:flutter/material.dart';

class CoffeeCard extends StatelessWidget {
  const CoffeeCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.35, // Smaller width for the container
      height: size.height * 0.18, // Smaller height for the container
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 192, 186, 179),
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: const Color(0xff74a0b2).withOpacity(0.1), // Shadow color
            spreadRadius: 2, // Spread the shadow
            blurRadius: 5, // Blur the shadow
            offset: const Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -size.height * 0.017,
            left: -size.width * 0.08,
            child: ClipOval(
              clipBehavior: Clip.none,
              child: Image.asset(
                'assets/coffe_of_thday.png',
                width: size.width * 0.5, // Adjust the image width
                height: size.height * 0.12, // Adjust the image height
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.08, // Adjust padding for text
              bottom: size.height * 0.01, // Add padding to avoid overflow
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center, // Center content
              children: [
                Text(
                  'Cappuccino', // Item name
                  style: TextStyle(
                    fontSize: size.width * 0.035, // Adjusted font size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,
                        color: Colors.yellow, size: size.width * 0.04),
                    Icon(Icons.star,
                        color: Colors.yellow, size: size.width * 0.04),
                    Icon(Icons.star,
                        color: Colors.yellow, size: size.width * 0.04),
                    Icon(Icons.star,
                        color: Colors.yellow, size: size.width * 0.04),
                    Icon(Icons.star_half,
                        color: Colors.yellow, size: size.width * 0.04),
                  ],
                ),
                SizedBox(
                    height: size.height *
                        0.005), // Adjust space between stars and price
                Text(
                  '\$4.99', // Price
                  style: TextStyle(
                    fontSize: size.width * 0.04, // Adjusted font size for price
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 105,
            right: -9,
            child: Material(
              color: Colors.transparent, // Ensure transparency
              child: IconButton(
                onPressed: () {
                  log('hello');
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Color(0xffC67C4E),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}