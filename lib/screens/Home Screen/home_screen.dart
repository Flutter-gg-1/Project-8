import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/screens/Home%20Screen/ProductDetailsScreen.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/profile/profile.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0; // Track the selected tab index

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  final List<String> imgList = [
    'assets/Group 3174.png',
    'assets/ab.png',
    'assets/ss 1 (1).png',
  ];
  final List<String> urls = [
    'https://www.google.com',
    'https://www.facebook.com',
    'https://www.twitter.com',
    'https://www.instagram.com',
    'https://onze.cafe/'
  ];
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'John Doe',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: const Text(
                'john.doe@example.com',
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/11.jpg'),
              ),
              decoration: const BoxDecoration(
                color: Color(0xff3d6b7d),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title:
                  const Text('Profile', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.black),
              title:
                  const Text('About Us', style: TextStyle(color: Colors.black)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.black),
              title:
                  const Text('Log Out', style: TextStyle(color: Colors.black)),
              onTap: () {
                locator.get<DataLayer>().logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xff3D6B7D),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/onze logo.png',
          height: 200,
        ),
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
      body: Column(
        children: [
          // Sliver AppBar equivalent
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                ClipRRect(
                  child: Container(
                      width: double.infinity,
                      height: size.height * 0.32,
                      color: const Color(0xff87b1c5),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: size.height * 0.25,
                          aspectRatio: 16 / 9,
                          viewportFraction:
                              0.9, // Set to 0.9 for small space between items
                        ),
                        items: imgList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 35), // Original top margin
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.2), // Light shadow
                                          spreadRadius: 0, // No extra spread
                                          blurRadius:
                                              10, // Slightly larger blur
                                          offset: const Offset(0,
                                              5), // Shadow is moved 5 pixels down
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      item,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      )),
                ),
                Positioned(
                  top: size.height * 0.003,
                  left: size.width * 0.25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Good morning ☀️',
                        style: TextStyle(
                          color: const Color(0xff3D6B7D),
                          fontSize: size.width * 0.04,
                        ),
                      ),
                      Text(
                        'Coffee for you ☕️',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.1950,
                  left: -size.width * 0.05,
                  child: Hero(
                    tag: 'coffeeHero_mainImage',
                    child: Image.asset(
                      'assets/Artboard 1 copy 10 1.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Tab Bar with Custom Design
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10), // Add padding here
            child: TabBar(
              isScrollable: true,
              // Enable scrolling for the tabs
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffa8483d),
              ),
              labelColor: Colors.white,
              unselectedLabelColor:
                  Colors.black, // Text color for unselected tabs
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              tabs: const [
                Tab(text: 'Classic Coffee Drinks'),
                Tab(text: 'Cold Drinks'),
                Tab(text: 'Drip Coffee'),
                Tab(text: 'Tea Drinks'),
                Tab(text: 'Water'),
                Tab(text: 'Dessert'),
              ],
            ),
          ),

          // Tab Bar View
          Expanded(
            flex: 3,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildGrid(size, 'classicCoffee'),
                _buildGrid(size, 'coldDrinks'),
                _buildGrid(size, 'dripCoffee'),
                _buildGrid(size, 'teaDrinks'),
                _buildGrid(size, 'water'),
                _buildGrid(size, 'dessert'),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80,
        width: double.infinity,
        color: const Color(0xff3D6B7D),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white),
                  onPressed: () => _launchURL(urls[0]),
                ),
                IconButton(
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  onPressed: () => _launchURL(urls[1]),
                ),
                IconButton(
                  icon: const Icon(Icons.shape_line, color: Colors.white),
                  onPressed: () => _launchURL(urls[2]),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () => _launchURL(urls[3]),
                ),
              ],
            ),
            InkWell(
                onTap: () => _launchURL(urls[4]),
                child: Text(
                  'For more information visit our website',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(Size size, String category) {
    // Simulate different items for each category
    List<String> items = [];
    if (category == 'classicCoffee') {
      items = ['Espresso', 'Latte', 'Cappuccino'];
    } else if (category == 'coldDrinks') {
      items = ['Iced Latte', 'Iced Americano', 'Iced Spanish Latte'];
    } else if (category == 'dripCoffee') {
      items = ['Hot Chemex', 'Hot V60'];
    } else if (category == 'teaDrinks') {
      items = ['Red Tea', 'Iced Hibiscus', 'Iced Tea'];
    } else if (category == 'water') {
      items = ['Water', 'Sparkling Water'];
    } else if (category == 'dessert') {
      items = ['Pastel de Nata', 'Large Cinnamon Roll', 'Pecan Tart'];
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Display two items in a row
          crossAxisSpacing: 10,
          mainAxisSpacing: 25,
          childAspectRatio: 3 / 2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final String heroTag = '$category-$index';
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    heroTag: heroTag,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: _selectedTabIndex == _tabController.index
                    ? Colors.black.withOpacity(0.05)
                    : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Hero(
                tag: heroTag,
                child:
                    CoffeeCard(size: size), // Replace with actual coffee data
              ),
            ),
          );
        },
      ),
    );
  }
}
