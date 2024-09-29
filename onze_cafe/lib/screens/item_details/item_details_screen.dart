import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/reusable_components/buttons/circle_btn.dart';
import 'package:onze_cafe/reusable_components/count_view.dart';
import 'package:onze_cafe/screens/item_details/subviews/coffee_strength_view.dart';
import 'package:onze_cafe/screens/item_details/subviews/size_selection_view.dart';
import 'package:onze_cafe/screens/item_details/subviews/milk_slider_view.dart';
import 'package:onze_cafe/screens/item_details/item_details_cubit.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

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
          backgroundColor: C.primary(brightness),
          body: Column(
            children: [
              BlocBuilder<ItemDetailsCubit, ItemDetailsState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Stack(
                          children: [
                            AspectRatio(
                                aspectRatio: 1.3,
                                child: Image(
                                  image: Img.americano,
                                  fit: BoxFit.cover,
                                )),
                            Column(
                              children: [
                                AspectRatio(
                                    aspectRatio: 1.5,
                                    child:
                                        Placeholder(color: Colors.transparent)),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: G.primary,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(24),
                                      topLeft: Radius.circular(24),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _TitleView(item: item),
                                        SizeSelectionView(cubit: cubit),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0, vertical: 16),
                                          child: Divider(
                                            color: C
                                                .bg2(brightness)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        MilkSliderView(
                                          cubit: cubit,
                                          title: milkOptions[cubit.milkSlider],
                                        ),
                                        SizedBox(height: 8),
                                        CoffeeStrengthView(cubit: cubit),
                                        CountView(
                                          count: cubit.quantity,
                                          onDecrement: cubit.decrementCount,
                                          onIncrement: cubit.incrementCount,
                                          iconColor: C.accent(brightness),
                                          iconSize: 40,
                                          fSize: 24,
                                          fColor: C.bg1(brightness),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => (),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomPaint(
                                                size: Size(0,
                                                    90), // Specify the size for your custom painting
                                                painter: CircleBtn()),
                                          ),
                                        ],
                                      ),
                                      Text('Add To Cart').styled(
                                          size: 16,
                                          color: C.bg1(brightness),
                                          weight: FontWeight.bold)
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
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

class _TitleView extends StatelessWidget {
  const _TitleView({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(item.name).styled(
                color: C.bg1(brightness), weight: FontWeight.bold, size: 24),
            Text('${item.price} SAR').styled(
                color: C.secondary(brightness),
                weight: FontWeight.bold,
                size: 20),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${item.calories} Calories').styled(
                color: C.bg1(brightness), weight: FontWeight.w300, size: 16),
            Text('${item.oz} oz').styled(
                color: C.bg1(brightness), weight: FontWeight.w300, size: 16),
          ],
        )
      ],
    );
  }
}
