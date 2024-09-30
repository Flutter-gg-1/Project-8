import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:onze_cafe/screens/Home%20Screen/ProductDetailsScreen.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/Home%20Screen/custom_drawer.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/utils/launch_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

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

  // Fetch products from Supabase based on item_type
  Future<List<Map<String, dynamic>>> _getProductsFromDatabase(
      String itemType) async {
    const itemTypeMap = {
      "classicCoffee": "Classic Coffee Drinks",
      "coldDrinks": "Cold Drinks",
      "dripCoffee": "Drip Coffee",
      "teaDrinks": "Tea Drinks",
      "water": "Water",
      "dessert": "Dessert"
    };

    if (!itemTypeMap.containsKey(itemType)) {
      throw Exception('Invalid item_type: $itemType');
    }

    final dbItemType = itemTypeMap[itemType];

    try {
      final response = await Supabase.instance.client
          .from("item")
          .select("*")
          .eq("item_type", dbItemType!);

      if (response == null || response.isEmpty) {
        throw Exception('Error fetching products or no data available');
      }

      return List<Map<String, dynamic>>.from(response as List);
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
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
          Column(
            children: [
              // if cart empty, sizedbox 20
              // SizedBox(
              //   height: 20,
              // ),
              // if cart not empty, show column
              Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xffa8483d)),
                    child: const Center(
                        child: Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    )),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 20,
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
                          viewportFraction: 0.9,
                        ),
                        items: imgList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                margin: const EdgeInsets.only(top: 35),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5),
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
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              dividerColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffa8483d),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
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
                _buildProductsGrid('classicCoffee', size),
                _buildProductsGrid('coldDrinks', size),
                _buildProductsGrid('dripCoffee', size),
                _buildProductsGrid('teaDrinks', size),
                _buildProductsGrid('water', size),
                _buildProductsGrid('dessert', size),
              ],
            ),
          ),

          const SizedBox(height: 100),
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
                  onPressed: () => launchURL(urls[0]),
                ),
                IconButton(
                  icon: const Icon(Icons.facebook, color: Colors.white),
                  onPressed: () => launchURL(urls[1]),
                ),
                IconButton(
                  icon: const Icon(Icons.shape_line, color: Colors.white),
                  onPressed: () => launchURL(urls[2]),
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.white),
                  onPressed: () => launchURL(urls[3]),
                ),
              ],
            ),
            InkWell(
                onTap: () => launchURL(urls[4]),
                child: const Text(
                  'For more information visit our website',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildProductsGrid(String itemType, Size size) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getProductsFromDatabase(itemType),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        final products = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 25,
              childAspectRatio: 3 / 2,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        heroTag: product['id'].toString(),
                      ),
                    ),
                  );
                },
                child: CoffeeCard(
                  size: size,
                  name: product['name'] ?? 'Unknown Product',
                  price: product['price'] != null
                      ? product['price'].toDouble()
                      : 0.0,
                  imageUrl: product['image_url'],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
