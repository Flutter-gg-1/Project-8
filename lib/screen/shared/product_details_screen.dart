import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_coffee_app/cubits/cart_cubit/cart_cubit.dart';
import 'package:onze_coffee_app/models/product_model.dart';
import 'package:onze_coffee_app/screen/user/user_cart_screen.dart';
import 'package:onze_coffee_app/widget/comment/custom_button_bottom_sheet.dart';
import 'package:onze_coffee_app/widget/product_description.dart';
import 'package:onze_coffee_app/widget/product_title.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Detail")),
      ),
      bottomSheet: BlocProvider(
        create: (context) => CartCubit(),
        child: Builder(builder: (context) {
          final cartReadCubit = context.read<CartCubit>();
          return CustomButtonBottomSheet(
            title: "Add to Cart",
            price: product.variants.first.price.toString(),
            onPressed: () {
              cartReadCubit.addItemsToCart(
                  product: product,
                  qnty: 1,
                  productVarient: product.variants.first);

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserCartScreen(
                          myCart: cartReadCubit.myCart,
                        )),
              );
            },
          );
        }),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              product.imageUrls.isEmpty
                  ? Image.network(product.imageUrls.first)
                  : Image.asset("assets/logo/onze_logo.png"),
              ProductTitle(
                name: product.productName,
                cal: product.variants.first.calories.toString(),
                type: product.tempreture,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Divider(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      "Description"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProductDescription(description: product.description),
              const SizedBox(
                height: 30,
              ),
              const Text("scolling images")
            ],
          ),
        ),
      ),
    );
  }
}