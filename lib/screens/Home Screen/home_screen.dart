import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:onze_cafe/screens/Auth%20Screens/first_screen.dart';
import 'package:onze_cafe/screens/Home%20Screen/ProductDetailsScreen.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/screens/profile/profile.dart';
import 'package:onze_cafe/services/setup.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> imgList = [
      'assets/11.jpg',
      'assets/11.jpg',
      'assets/11.jpg',
    ];

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
                backgroundImage: AssetImage(locator.get<DataLayer>().user!.imageUrl),
              ),
              decoration: const BoxDecoration(
                color: Color(0xff74a0b2),
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
        backgroundColor: const Color(0xff74a0b2),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.3,
            floating: false,
            pinned: false,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: size.height * 0.32,
                      color: const Color(0xff74a0b2),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: size.height * 0.25,
                          aspectRatio: 16 / 9,
                          // enlargeCenterPage: true,
                        ),
                        items: imgList.map((item) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                // width: size.width * 0.65,
                                // height: size.height * 0.01,
                                margin: const EdgeInsets.only(top: 35),
                                // إضافة الحواف الدائرية للصور
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(25), // حواف دائرية
                                  child: Image.asset(
                                    item,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // النص والصورة فوق السلايدر
                  Positioned(
                    top: -size.height * 0.003,
                    left: size.width * 0.02,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning ☀️',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.03,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.01),
                          child: Text(
                            'Coffee for you ☕️',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.12,
                    right: -size.width * 0.06,
                    child: Hero(
                      tag: 'coffeeHero_mainImage',
                      child: Image.asset(
                        'assets/a.png',
                        fit: BoxFit.contain,
                        width: size.width * 0.25,
                        height: size.height * 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 20,
                  ),
                  child: SizedBox(
                    height: size.height * 0.06,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.5),
                        hintText: 'What would you like to drink today...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon:
                            const Icon(Icons.coffee, color: Colors.black),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                  ),
                  child: const Text(
                    'Coffee',
                    style: TextStyle(
                      color: Color.fromARGB(255, 84, 83, 83),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final String heroTag = 'coffeeHero_$index';
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
                        child: Hero(
                          tag: heroTag,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CoffeeCard(size: size),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // const SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: size.width * 0.05,
                //   ),
                //   child: const Text(
                //     'Desserts',
                //     style: TextStyle(
                //       color: Color.fromARGB(255, 84, 83, 83),
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   height: size.height * 0.2,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     clipBehavior: Clip.none,
                //     itemCount: 3,
                //     itemBuilder: (context, index) {
                //       final String heroTag = 'dessertHero_$index';
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ProductDetailsScreen(
                //                 heroTag: heroTag,
                //               ),
                //             ),
                //           );
                //         },
                //         child: Hero(
                //           tag: heroTag,
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 10),
                //             child: CoffeeCard(size: size),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: size.width * 0.05,
                //   ),
                //   child: const Text(
                //     'Most Ordered',
                //     style: TextStyle(
                //       color: Color.fromARGB(255, 84, 83, 83),
                //       fontSize: 22,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // SizedBox(
                //   height: size.height * 0.2,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     clipBehavior: Clip.none,
                //     itemCount: 3,
                //     itemBuilder: (context, index) {
                //       final String heroTag = 'mostOrdered_$index';
                //       return GestureDetector(
                //         onTap: () {
                //           Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //               builder: (context) => ProductDetailsScreen(
                //                 heroTag: heroTag,
                //               ),
                //             ),
                //           );
                //         },
                //         child: Hero(
                //           tag: heroTag,
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 10),
                //             child: CoffeeCard(size: size),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
