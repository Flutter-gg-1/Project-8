import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String heroTag; // Hero tag passed from the HomeScreen

  const ProductDetailsScreen({required this.heroTag});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = '8 oz'; // Default selected size
  int quantity = 1; // Default quantity

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          // Top part with background color
          Container(
            width: double.infinity,
            color: const Color(
                0xff74a0b2), // Use the blue-grey color as background
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.1,
                bottom: 20,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: Column(
                children: [
                  // Product Image with Hero animation
                  Center(
                    child: Hero(
                      tag: widget
                          .heroTag, // Use unique heroTag for the animation
                      child: Image.asset(
                        'assets/coffe_of_thday.png',
                        width: size.width * 0.6,
                        height: size.height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rest of the content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cappuccino', // Product name
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'A delicious hot cappuccino with steamed milk and a rich espresso base.',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: size.width * 0.045,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Select Size',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSizeOption('8 oz'),
                        _buildSizeOption('10 oz'),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quantity',
                      style: TextStyle(
                        color: Colors.black,
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
                          icon: const Icon(Icons.remove, color: Colors.black),
                        ),
                        Text(
                          '$quantity',
                          style: TextStyle(
                            color: Colors.black,
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
                          icon: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff74a0b2),
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.3, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          // Add to cart functionality
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
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
        ],
      ),
    );
  }

  Widget _buildSizeOption(String size) {
    final isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff74a0b2)
              : Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          size,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
