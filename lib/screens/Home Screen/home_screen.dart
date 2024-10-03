import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';

import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/Proudct_details/ProductDetailsScreen.dart';
import 'package:onze_cafe/screens/Home%20Screen/bloc/home_bloc.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/Home%20Screen/custom_drawer.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:onze_cafe/utils/launch_url.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CarouselController _carouselController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _carouselController = CarouselController();
  }

  Widget _buildProductsGrid(String itemType, Size size) {
    return BlocProvider(
      create: (context) =>
          HomeBloc(locator.get<DataLayer>())..add(LoadProductsEvent(itemType)),
      child: BlocBuilder<HomeBloc, HomeBlocState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeErrorState) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is HomeLoadedState) {
            final products = state.products;
            if (products.isEmpty) {
              return const Center(child: Text('No products available'));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 25,
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
                            heroTag: product.id.toString(),
                            item: ItemModel.fromJson(products[index].toJson()),
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: product.id.toString(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CoffeeCard(
                          size: size,
                          name: product.name,
                          price: product.price,
                          imageUrl: product.imageUrl,
                          rating: product.rating,
                          itemId: product.id,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff3D6B7D),
                          const Color(0xff87B1C5),
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 12,
                          offset: const Offset(0, 1),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(360),
                        bottomRight: Radius.circular(360),
                      ),
                    ),
                    width: size.width * 3,
                    height: size.height * 0.4,
                    child: CarouselSlider.builder(
                      itemCount: 3,
                      itemBuilder: (context, index, realIndex) {
                        final imagePaths = [
                          'assets/cup3 2.png',
                          'assets/WhatsApp Image 2024-10-02 at 1.46.05 PM.png',
                          'assets/cup1 1.png',
                        ];
                        return Transform.translate(
                          offset: Offset(0, 150),
                          child: ClipRRect(
                            child: Image.asset(
                              imagePaths[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        clipBehavior: Clip.none,
                        autoPlay: true,
                        height: size.height * 0.23,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.9,
                        onPageChanged: (index, reason) {},
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: size.width * 0.24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/onze logo.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: size.width * 0.26,
                    child: Column(
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
                ],
              ),
            ),
            actions: [
              Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffa8483d),
                    ),
                    child: const Center(
                      child: Text(
                        '2',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 8),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen()),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: _tabController,
                    dividerHeight: 0,
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
                      Tab(text: 'Bakery'),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
