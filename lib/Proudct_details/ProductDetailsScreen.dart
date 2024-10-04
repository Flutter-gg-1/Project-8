import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/Proudct_details/product_details_bloc/product_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/cart_screen/cart_screen.dart';
import 'package:onze_cafe/services/setup.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String heroTag;
  final ItemModel item;

  const ProductDetailsScreen({
    required this.heroTag,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProductDetailsBloc(),
      child: Builder(
        builder: (context) {
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
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()),
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
                    child: Column(
                      children: [
                        Center(
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
                      ],
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
                      child:
                          BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
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
                          final bloc = context.read<ProductDetailsBloc>();
                          return Column(
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
                                'Select Size',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSizeOption(context, '8 oz'),
                                  _buildSizeOption(context, '10 oz'),
                                ],
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
                                      if (bloc.quantity > 1) {
                                        bloc.add(ChangeQuantityEvent(
                                            bloc.quantity - 1));
                                      }
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Colors.black),
                                  ),
                                  BlocBuilder<ProductDetailsBloc,
                                      ProductDetailsState>(
                                    buildWhen: (previous, current) =>
                                        current is ProductQuantityUpdated,
                                    builder: (context, state) {
                                      final quantity = bloc.quantity;
                                      return Text(
                                        '$quantity',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: size.width * 0.06,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bloc.add(ChangeQuantityEvent(
                                          bloc.quantity + 1));
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
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async {
                                    bloc.add(AddToCartEvent(
                                      itemId: item.id,
                                      orderId: locator
                                          .get<DataLayer>()
                                          .order!
                                          .orderId,
                                      quantity: bloc.quantity,
                                      price: item.price,
                                    ));
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
                          );
                        },
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

  Widget _buildSizeOption(BuildContext context, String size) {
    final bloc = context.read<ProductDetailsBloc>();

    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      buildWhen: (previous, current) => current is ProductSizeUpdated,
      builder: (context, state) {
        final isSelected = bloc.selectedSize == size;
        return GestureDetector(
          onTap: () {
            bloc.add(ChangeSizeEvent(size));
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
      },
    );
  }
}
