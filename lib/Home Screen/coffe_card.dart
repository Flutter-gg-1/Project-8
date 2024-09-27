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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent, // Transparent at the top
            const Color(0x3038353a)
                .withOpacity(0.8), // Semi-transparent at the bottom
          ],
        ),
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 2, // Spread the shadow
            blurRadius: 5, // Blur the shadow
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -size.height * 0.01,
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
                    color: Color(0xffbc793d),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
