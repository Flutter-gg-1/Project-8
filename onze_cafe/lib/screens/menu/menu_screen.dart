import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/reusable_components/cards/Item_view.dart';
import 'package:onze_cafe/reusable_components/slider/offers_slider.dart';
import 'package:onze_cafe/reusable_components/tab/categoryTab.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => MenuCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<MenuCubit>();
        return Scaffold(
          backgroundColor: C.primary(brightness),
          appBar: AppBar(
            backgroundColor: C.primary(brightness),
            // automaticallyImplyLeading: false,
            title: AspectRatio(
                aspectRatio: 7, child: Image.asset("assets/logo1.png")),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () => cubit.navigateToCart(context),
                    icon: Icon(
                      Icons.shopping_basket,
                      color: C.bg2(brightness),
                      size: 30,
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Hi User").styled(
                          color: C.bg2(brightness),
                          size: 24,
                          weight: FontWeight.bold),
                      const Text("It is a great day to grab a cup of coffee")
                          .styled(
                        color: C.bg2(brightness),
                        size: 14,
                      ),
                    ],
                  ),
                ),
                BlocBuilder<MenuCubit, MenuState>(
                  builder: (context, state) {
                    if (state is MenuInitial) {
                      cubit.fetchMenuItems();
                      cubit.fetchCategories();
                    }
                    return Container(
                      decoration: BoxDecoration(
                          color: C.bg1(brightness),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CategoryTab(
                            categories: cubit.categories,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: const Text("Offers")
                                .styled(weight: FontWeight.bold, size: 24),
                          ),
                          const OffersSlider(),
                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: cubit.menuItems
                                .map((item) => InkWell(
                                    onTap: () => cubit.navigateToItemDetails(
                                        context, item),
                                    child: ItemView(item: item)))
                                .toList(),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class ViewCategory extends StatelessWidget {
  const ViewCategory({super.key, required this.category, required this.index});
  final MenuCategory category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(category.name).styled(weight: FontWeight.bold, size: 24),
          Divider(),
        ],
      ),
    );
  }
}
