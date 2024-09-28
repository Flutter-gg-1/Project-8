import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/reusable_components/views/coffee_strength_view.dart';
import 'package:onze_cafe/reusable_components/views/count_view.dart';
import 'package:onze_cafe/reusable_components/views/size_view.dart';
import 'package:onze_cafe/reusable_components/views/slider_view.dart';
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back)),
                        ),
                        AspectRatio(
                            aspectRatio: 1.5,
                            child: Image(
                              image: Img.americano,
                              fit: BoxFit.cover,
                            )),
                        AspectRatio(
                          aspectRatio: 0.78,
                          child: Container(
                            decoration: BoxDecoration(
                                color: C.primary(brightness),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  CountView(cubit: cubit)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
              TextButton(onPressed: () => (), child: const Text('Add to Cart'))
            ],
          ),
        );
      }),
    );
  }
}
