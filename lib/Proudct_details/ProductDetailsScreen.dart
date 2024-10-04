import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/Proudct_details/bloc/product_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/services/setup.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String heroTag;
  final ItemModel item;

  const ProductDetailsScreen({required this.heroTag, required this.item});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProductDetailsBloc(DataLayer()),
      child: Builder(builder: (context) {
        return BlocConsumer<ProductDetailsBloc, ProductState>(
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
            final productBloc = BlocProvider.of<ProductDetailsBloc>(context);

            int quantity = 1;

            if (state is ProductQuantityUpdated) {
              quantity = state.quantity;
            }

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
                          tag: heroTag,
                          child: Image.network(
                            item.imageUrl,
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
                              item.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * 0.07,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: size.width * 0.045,
                              ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (quantity > 1) {
                                      productBloc.add(
                                          ChangeQuantityEvent(quantity - 1));
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
                                    productBloc
                                        .add(ChangeQuantityEvent(quantity + 1));
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            Center(
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
                                onPressed: () async {
                                  final orderId =
                                      locator.get<DataLayer>().order?.orderId;

                                  if (orderId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Order ID is missing!')),
                                    );
                                    return;
                                  }

                                  productBloc.add(
                                    AddToCartEvent(
                                      itemId: item.id,
                                      orderId: orderId,
                                      quantity: quantity,
                                      price: item.price,
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
          },
        );
      }),
    );
  }
}
