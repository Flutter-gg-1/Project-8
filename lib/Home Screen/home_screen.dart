import 'package:flutter/material.dart';
import 'package:onze_cafe/Home%20Screen/coffe_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Get screen size

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        extendBodyBehindAppBar:
            true, // Allow content to appear behind the AppBar
        drawer: const Drawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent, // Transparent AppBar
          elevation: 0, // Remove shadow
          iconTheme: const IconThemeData(
            color: Colors.white, // Keep icons white
          ),
          actions: [
            IconButton(
              onPressed: () {},
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
                                fontSize:
                                    size.width * 0.07, // Dynamic font size
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
                        prefixIcon:
                            const Icon(Icons.coffee, color: Colors.white),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  indicator: BoxDecoration(),
                  labelColor: Color.fromARGB(255, 116, 160, 178),
                  unselectedLabelColor: Colors.white,
                  labelStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  dividerHeight: 0,
                  labelPadding: EdgeInsets.symmetric(
                      horizontal: 2), // Adjust spacing between tabs
                  tabs: [
                    Tab(text: 'Coffee'),
                    Tab(text: 'Desserts'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                CoffeeCard(size: size),
                                SizedBox(
                                  width: 20,
                                ),
                                CoffeeCard(size: size),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Center(
                          child: Text('Dessert Menu',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}