import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/custom_refresh/refresh.dart';
import 'package:onze_cafe/screens/drawer/drawer_screen.dart';
import 'package:onze_cafe/screens/menu/subviews/Item_view.dart';
import 'package:onze_cafe/screens/menu/subviews/categoryTab.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';
import 'package:onze_cafe/screens/menu/subviews/offers_view.dart';

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
                    color: C.bg1(brightness),
                    size: 30,
                  ),
                ),
              )
            ],
          ),
          drawer: DrawerScreen(),
          body: Refresh(
            refreshController: cubit.refreshController,
            onRefresh: cubit.handleRefresh,
            bgColor: C.primary(brightness),
            gif: Img.loading2,
            child: ListView(controller: cubit.scrollController, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Hi User").styled(
                                color: C.bg1(brightness),
                                size: 24,
                                weight: FontWeight.bold),
                            const Text(
                                    "It is a great day to grab a cup of coffee")
                                .styled(
                              color: C.bg1(brightness),
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: AspectRatio(
                            aspectRatio: 2,
                            child: Image(image: Img.illustration9)),
                      )
                    ],
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
                            OffersView(),
                            ListView.builder(
                              controller: cubit.scrollController,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: cubit.categories.length,
                              itemBuilder: (context, index) {
                                var category = cubit.categories[index];
                                var menuItems =
                                    cubit.categorizedMenuItems[category.id] ??
                                        [];
                                return LayoutBuilder(
                                  builder: (context, constraints) {
                                    // Capture position once layout is complete
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      final box = context.findRenderObject()
                                          as RenderBox?;
                                      if (box != null) {
                                        final position =
                                            box.localToGlobal(Offset.zero).dy -
                                                100;
                                        cubit.setCategoryPosition(
                                            category.id ?? '', position);
                                      }
                                    });
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            category.name,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
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
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ]),
          ),
        );
      }),
    );
  }
}
