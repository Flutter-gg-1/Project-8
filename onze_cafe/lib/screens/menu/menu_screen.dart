import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/drawer/drawer_screen.dart';
import 'package:onze_cafe/screens/menu/subviews/Item_view.dart';
import 'package:onze_cafe/screens/menu/subviews/offers_slider.dart';
import 'package:onze_cafe/screens/menu/subviews/categoryTab.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';

import '../../extensions/img_ext.dart';

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
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu, color: C.bg1(brightness)),
                );
              },
            ),
            title: AspectRatio(aspectRatio: 7, child: Image(image: Img.logo1)),
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
                  ),
                ),
              )
            ],
          ),
          drawer: DrawerScreen(),
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
                    }
                    return Container(
                      decoration: BoxDecoration(
                          color: C.bg1(brightness),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: Column(
                        children: [
                          CategoryTab(cubit: cubit),
                          _OffersView(),
                          ListView.builder(
                            controller: cubit.scrollController,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.categories.length,
                            itemBuilder: (context, index) {
                              var category = cubit.categories[index];
                              var menuItems =
                                  cubit.categorizedMenuItems[category.id] ?? [];

                              return LayoutBuilder(
                                builder: (context, constraints) {
                                  // Call this to capture the position once layout is complete
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    final box = context.findRenderObject()
                                        as RenderBox?;
                                    if (box != null) {
                                      final position =
                                          box.localToGlobal(Offset.zero).dy;
                                      cubit.setCategoryPosition(
                                          category.id, position);
                                    }
                                  });

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Category header
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          category.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      // Grid of menu items under the category
                                      GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children: menuItems.isNotEmpty
                                            ? menuItems
                                                .map((item) => InkWell(
                                                    onTap: () => cubit
                                                        .navigateToItemDetails(
                                                            context, item),
                                                    child:
                                                        ItemView(item: item)))
                                                .toList()
                                            : [Text('No Items')],
                                      ),
                                    ],
                                  );
                                },
                              );
                              ;
                            },
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

class _OffersView extends StatelessWidget {
  const _OffersView();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: const Text("Offers").styled(weight: FontWeight.bold, size: 18),
        ),
        const OffersSlider(),
      ],
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
