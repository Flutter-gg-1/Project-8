import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = 'Medium'; // Default selected size
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/Group 3155.png', // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          // Foreground content
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height, // Ensure full screen height
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Image
                      Center(
                        child: Image.asset(
                          'assets/coffe_of_thday.png', // Replace with your product image
                          width: size.width * 0.6,
                          height: size.height * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Product Name
                      Text(
                        'Cappuccino', // Replace with dynamic product name
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Product Description
                      Text(
                        'A delicious hot cappuccino with steamed milk and a rich espresso base.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Size Selection
                      Text(
                        'Select Size',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSizeOption('Small'),
                          _buildSizeOption('Medium'),
                          _buildSizeOption('Large'),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Quantity Selector
                      Text(
                        'Quantity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) quantity--;
                              });
                            },
                            icon: Icon(Icons.remove, color: Colors.white),
                          ),
                          Text(
                            '$quantity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            icon: Icon(Icons.add, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      // Add to Cart Button
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffbc793d), // Button color
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.3, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () {
                            // Add to cart functionality
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Added to cart!'),
                              ),
                            );
                          },
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build size option button
  Widget _buildSizeOption(String size) {
    final isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xffbc793d) : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
