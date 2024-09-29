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
              child: Image.asset(
                'assets/coffe_of_thday.png',
                width: size.width * 0.55,
                height: size.height * 0.09,
                fit: BoxFit.contain,
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
                  'Cappuccino', // Item name
                  style: TextStyle(
                    fontSize: size.width * 0.03, // Adjusted font size
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Lighter creamy text color
                  ),
                ),
                SizedBox(height: size.height * 0.004), // Reduced spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,
                        color: const Color(0xffFFD700), // Gold color for stars
                        size: size.width * 0.03), // Smaller icon size
                    Icon(Icons.star,
                        color: const Color(0xffFFD700), // Gold color for stars
                        size: size.width * 0.03), // Smaller icon size
                    Icon(Icons.star,
                        color: const Color(0xffFFD700), // Gold color for stars
                        size: size.width * 0.03), // Smaller icon size
                    Icon(Icons.star,
                        color: const Color(0xffFFD700), // Gold color for stars
                        size: size.width * 0.03), // Smaller icon size
                    Icon(Icons.star_half,
                        color:
                            const Color(0xffFFD700), // Gold color for half star
                        size: size.width * 0.03), // Smaller icon size
                  ],
                ),
                SizedBox(height: size.height * 0.004), // Reduced spacing
                Text(
                  '\$4.99', // Price
                  style: TextStyle(
                    fontSize:
                        size.width * 0.032, // Adjusted font size for price
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Lighter creamy text color
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
                  log('hello');
                },
                icon: const Icon(
                  Icons.add_box,
                  color: Color(0xffA8483D), // Warm light brown color for icon
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
