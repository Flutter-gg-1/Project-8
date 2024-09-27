import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/cart_screen.dart';
import 'package:onze_cafe/screens/menu/menu_cubit.dart';

import '../item_details_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<MenuCubit>();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Menu Screen'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => cubit.navigateToCart(context),
                  icon: const Icon(Icons.shopping_cart))
            ],
          ),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<MenuCubit, MenuState>(
                    builder: (context, state) {
                      if (state is MenuInitial) cubit.fetchMenuItems();
                      return ListView(
                        children: cubit.menuItems
                            .map((item) => InkWell(
                                onTap: () =>
                                    cubit.navigateToItemDetails(context, item),
                                child: ItemView(item: item)))
                            .toList(),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
        );
      }),
    );
  }
}

class ItemView extends StatelessWidget {
  const ItemView({super.key, required this.item});
  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(item.name),
    );
  }
}
