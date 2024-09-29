import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/item_details/subviews/coffee_strength_view.dart';
import 'package:onze_cafe/reusable_components/count_view.dart';
import 'package:onze_cafe/screens/item_details/subviews/size_view.dart';
import 'package:onze_cafe/screens/item_details/subviews/slider_view.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final List<double> sizes = [60, 75, 90];
    final List<String> coffeeStrength = ["Light", "Medium", "Dark"];
    final List<String> milkOptions = [
      "Full Cream",
      "Creamy",
      "Skimmed Milk",
      "Low-Fat Milk"
    ];

    return BlocProvider(
      create: (context) => ItemDetailsCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ItemDetailsCubit>();
        return Scaffold(
          backgroundColor: C.bg1(brightness),
          body: Column(
            children: [
              BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        AspectRatio(
                            aspectRatio: 1.5,
                            child: Image(
                              image: Img.americano,
                              fit: BoxFit.cover,
                            )),
                        Container(
                          decoration: BoxDecoration(
                              color: C.primary(brightness),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(item.name).styled(
                                        color: C.bg1(brightness),
                                        weight: FontWeight.bold,
                                        size: 26),
                                    Text('${item.price} RS').styled(
                                        color: C.bg1(brightness),
                                        weight: FontWeight.bold,
                                        size: 24),
                                  ],
                                ),
                                Text("Size").styled(
                                    color: C.bg1(brightness),
                                    weight: FontWeight.w600,
                                    size: 18),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(3, (index) {
                                    return SizeView(
                                      cubit: cubit,
                                      index: index,
                                      size: sizes[index],
                                    );
                                  }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: Divider(
                                    color: C.bg2(brightness),
                                  ),
                                ),
                                Text("Milk").styled(
                                    color: C.bg1(brightness),
                                    weight: FontWeight.w600,
                                    size: 18),
                                SliderView(
                                  cubit: cubit,
                                  title: '${milkOptions[cubit.sliderValue]}',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 26.0),
                                  child: Divider(
                                    color: C.bg2(brightness),
                                  ),
                                ),
                                Text("Coffee Strength").styled(
                                    color: C.bg1(brightness),
                                    weight: FontWeight.w600,
                                    size: 18),
                                AspectRatio(
                                  aspectRatio: 5,
                                  child: Expanded(
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(3, (index) {
                                        return CoffeeStrengthView(
                                          cubit: cubit,
                                          index: index,
                                          size: sizes[index],
                                          title: coffeeStrength[index],
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                                CountView(
                                  onDecrement: cubit.decrementCount,
                                  onIncrement: cubit.incrementCount,
                                  color: C.bg1(brightness),
                                  size: 40,
                                  count: cubit.itemCount,
                                  fSize: 30,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              //Not tested
              // TextButton(
              //    onPressed: () {
              //      final itemCount = cubit.itemCount;
              //      final selectedSize = sizes[cubit.selectedIndex].toString();
              //      final selectedCoffeeStrength = coffeeStrength[cubit.selectStrengthIndex];
              //      final selectedMilkOption = milkOptions[cubit.sliderValue];
              //
              //      final cartItem = CartItem(
              //        name: item.name,
              //        count: itemCount,
              //        price: item.price * itemCount,
              //        image: item.imgUrl,
              //        size: selectedSize,
              //        coffeeStrength: selectedCoffeeStrength,
              //        milkOption: selectedMilkOption,
              //      );
              //
              //      context.read<CartCubit>().addItem(cartItem);
              //      ScaffoldMessenger.of(context).showSnackBar(
              //        SnackBar(content: Text('${item.name} added to cart!')),
              //      );
              //    }, child: const Text('Add to Cart'))
            ],
          ),
        );
      }),
    );
  }
}
