import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/Proudct_details/product_details_bloc/product_bloc.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
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
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Center(
                        child: Hero(
                          tag: heroTag,
                          child: SizedBox(
                            height: 300,
                            width: 300,
                            child: Image.network(
                              item.imageUrl,
                              width: size.width * 0.6,
                              height: size.height * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                          color: Color(0xff3D6B7D),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xffE27D19),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${item.rating}',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0xff2F2D2C)),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text(
                                        '(reviews)',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color(0xff808080)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const Text(
                                'Description',
                                style: TextStyle(
                                    color: Color(0xff3D6B7D),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.description,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Select Size',
                                style: TextStyle(
                                  color: const Color(0xff3D6B7D),
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSizeOption(context, 'S'),
                                  _buildSizeOption(context, 'M'),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Quantity',
                                style: TextStyle(
                                  color: const Color(0xff3D6B7D),
                                  fontSize: size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                    icon: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff3D6B7D),
                                      ),
                                      child: const Icon(Icons.remove,
                                          color: Colors.white),
                                    ),
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
                                    icon: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff3D6B7D),
                                      ),
                                      child: const Icon(Icons.add,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomSheet: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
              builder: (context, state) {
                final bloc = context.read<ProductDetailsBloc>();
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
                  height: 110,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xff3D6B7D)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'price',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            'SAR ${item.price * bloc.quantity}',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          )
                        ],
                      ),
                      Container(
                        width: size.width * 0.45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.transparent),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () async {
                            bloc.add(AddToCartEvent(
                              itemId: item.id,
                              orderId: locator.get<DataLayer>().order!.orderId,
                              quantity: bloc.quantity,
                              price: item.price,
                            ));
                          },
                          child: Text(
                            'Buy Now',
                            style: TextStyle(
                              color: const Color(0xff3D6B7D),
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.bold,
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
                  ? const Color(0xffA8483D)
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
