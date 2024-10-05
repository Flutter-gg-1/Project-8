import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/Proudct_details/ProductDetailsScreen.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/screens/Home%20Screen/coffe_card.dart';
import 'package:onze_cafe/screens/Home%20Screen/home_bloc/home_bloc.dart';

class BuildProductGrid extends StatefulWidget {
  final HomeBloc bloc;
  final String itemType;
  final Size size;
  const BuildProductGrid(
      {super.key, required this.bloc, required this.itemType, required this.size});

  @override
  State<BuildProductGrid> createState() => _BuildProductGridState();
}

class _BuildProductGridState extends State<BuildProductGrid> {
  @override
  void initState() {
    widget.bloc.add(LoadProductsEvent(widget.itemType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ErrorState) {
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
                      padding: const EdgeInsets.only(top: 20),
                      child: CoffeeCard(
                        size: widget.size,
                        name: product.name,
                        price: product.price,
                        imageUrl: product.imageUrl,
                        rating: product.rating,
                        itemId: product.id,
                        bloc: widget.bloc,
                        itemType: widget.itemType,
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
    );
  }
}
