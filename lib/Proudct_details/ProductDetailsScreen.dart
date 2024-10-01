import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/Proudct_details/bloc/product_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/services/setup.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String heroTag;
  final ItemModel item;

  const ProductDetailsScreen({required this.heroTag, required this.item});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProductDetailsBloc(locator.get<DataLayer>()),
      child: BlocBuilder<ProductDetailsBloc, ProductState>(
        builder: (context, state) {
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
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined,
                      color: Colors.white),
                ),
              ],
            ),
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xff74a0b2),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.1,
                      bottom: 20,
                      left: size.width * 0.05,
                      right: size.width * 0.05,
                    ),
                    child: Center(
                      child: Hero(
                        tag: widget.heroTag,
                        child: Image.network(
                          widget.item.imageUrl,
                          width: size.width * 0.6,
                          height: size.height * 0.3,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
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
                            widget.item.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.07,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            widget.item.description,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: size.width * 0.045,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Select Size',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          BlocBuilder<ProductDetailsBloc, ProductState>(
                            builder: (context, state) {
                              String selectedSize = '8 oz'; 
                              if (state is ProductSizeUpdated) {
                                selectedSize = state.selectedSize ?? '8 oz';
                              }

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ProductDetailsBloc>(
                                              context)
                                          .add(ChangeSizeEvent('8 oz'));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedSize == '8 oz'
                                            ? const Color(0xff74a0b2)
                                            : Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '8 oz',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<ProductDetailsBloc>(
                                              context)
                                          .add(ChangeSizeEvent('10 oz'));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedSize == '10 oz'
                                            ? const Color(0xff74a0b2)
                                            : Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        '10 oz',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Quantity',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          BlocBuilder<ProductDetailsBloc, ProductState>(
                            builder: (context, state) {
                              if (state is ProductQuantityUpdated) {
                                quantity = state.quantity;
                              }

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (quantity > 1) {
                                        BlocProvider.of<ProductDetailsBloc>(
                                                context)
                                            .add(
                                          ChangeQuantityEvent(quantity - 1),
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Colors.black),
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
                                      BlocProvider.of<ProductDetailsBloc>(
                                              context)
                                          .add(
                                        ChangeQuantityEvent(quantity + 1),
                                      );
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.black),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          BlocConsumer<ProductDetailsBloc, ProductState>(
                            listener: (context, state) {
                              if (state is ProductDetailsSuccess) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.message)),
                                );
                              } else if (state is ProductDetailsFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                              }
                            },
                            builder: (context, state) {
                              return Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff74a0b2),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.3,
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {
                                    print('$quantity');

                                    BlocProvider.of<ProductDetailsBloc>(context)
                                        .add(
                                      AddToCartEvent(
                                        itemId: widget.item.id,
                                        orderId: locator
                                            .get<DataLayer>()
                                            .order!
                                            .orderId,
                                        quantity: quantity,
                                        price: widget.item.price,

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
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
