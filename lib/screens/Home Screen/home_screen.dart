import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/Proudct_details/ProductDetailsScreen.dart';
import 'package:onze_cafe/screens/Home%20Screen/build_product_grid.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_bloc/home_bloc.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/Home%20Screen/custom_drawer.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: const CustomDrawer(),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                floating: true,
                iconTheme: const IconThemeData(color: Colors.white),
                backgroundColor: Colors.white,
                expandedHeight: size.height * 0.5,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff3D6B7D),
                              Color(0xff87B1C5),
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
                              offset: const Offset(0, 150),
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
                      const SizedBox(height: 15),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          int itemCount = 0;
                          if (state is UpdateCartCountState) {
                            itemCount = state.count;
                            if (itemCount == 0) {
                              return const SizedBox();
                            }
                            return Container(
                              height: 15,
                              width: 15,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffa8483d),
                              ),
                              child: Center(
                                child: Text(
                                  '$itemCount',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()),
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
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
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
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          final bloc = context.read<HomeBloc>();
                          return TabBarView(
                            controller: _tabController,
                            children: [
                              BuildProductGrid(bloc: bloc, itemType: 'classicCoffee', size: size),
                              BuildProductGrid(bloc: bloc, itemType: 'coldDrinks', size: size),
                              BuildProductGrid(bloc: bloc, itemType: 'dripCoffee', size: size),
                              BuildProductGrid(bloc: bloc, itemType: 'teaDrinks', size: size),
                              BuildProductGrid(bloc: bloc, itemType: 'water', size: size),
                              BuildProductGrid(bloc: bloc, itemType: 'dessert', size: size),
                              // _buildProductsGrid('classicCoffee', size, bloc),
                              // _buildProductsGrid('coldDrinks', size, bloc),
                              // _buildProductsGrid('dripCoffee', size, bloc),
                              // _buildProductsGrid('teaDrinks', size, bloc),
                              // _buildProductsGrid('water', size, bloc),
                              // _buildProductsGrid('dessert', size, bloc),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  
}
