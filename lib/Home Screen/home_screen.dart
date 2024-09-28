import 'package:flutter/material.dart';
import 'package:onze_cafe/Home%20Screen/ProductDetailsScreen.dart';
import 'package:onze_cafe/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/cart_screen/cart_screen.dart';
import 'package:onze_cafe/profile/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return Scaffold(
      extendBodyBehindAppBar: true, // Allow content to appear behind the AppBar
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header with profile image, name, and email
            UserAccountsDrawerHeader(
              accountName: Text(
                'John Doe', // Replace with your name
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                'john.doe@example.com', // Replace with your email
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 116, 160, 178),
              ),
            ),
            // Profile list tile
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            // About Us list tile
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context); // Close the drawer after selecting
              },
            ),
            // Log Out list tile
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context); // Close the drawer after selecting
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0, // Remove shadow
        iconTheme: const IconThemeData(
          color: Colors.white, // Keep icons white
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/Group 3155.png', // Replace with your image path
              fit: BoxFit.cover, // Make the image cover the entire background
            ),
          ),
          // Foreground content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, // Dynamic horizontal padding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.06),
                        Text(
                          'Good morning',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.04, // Dynamic font size
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Text(
                            'Coffee for you',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.07, // Dynamic font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Image.asset(
                        'assets/a.png',
                        fit: BoxFit.contain,
                        width: size.width * 0.25, // Dynamic width
                        height: size.height * 0.20, // Dynamic height
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, // Dynamic horizontal padding
                ),
                child: SizedBox(
                  height: size.height * 0.06, // Dynamic height
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.white), // User input text color
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black
                          .withOpacity(0.5), // Semi-transparent background
                      hintText: 'What would you like to drink today...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.coffee, color: Colors.white),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Coffee Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Text(
                  'Coffee',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Horizontal Scroll for Coffee
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: 4, // 3 Coffee items + 1 for See More
                  itemBuilder: (context, index) {
                    if (index == 3) {
                      // See More Button at the end
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            // Navigate to See More page
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.18,
                            decoration: BoxDecoration(
                              color: const Color(0xffbc793d),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'See More',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to product details when coffee is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CoffeeCard(size: size),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              // Dessert Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05,
                ),
                child: Text(
                  'Desserts',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Horizontal Scroll for Desserts
              SizedBox(
                height: size.height * 0.2, // Set the height for dessert cards
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: 4, // 3 Dessert items + 1 for See More
                  itemBuilder: (context, index) {
                    if (index == 3) {
                      // See More Button at the end
                      return Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            // Navigate to See More page
                          },
                          child: Container(
                            width: size.width * 0.35,
                            height: size.height * 0.18,
                            decoration: BoxDecoration(
                              color: const Color(0xffbc793d),
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'See More',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.045,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child:
                              CoffeeCard(size: size), // Change to DessertCard
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
