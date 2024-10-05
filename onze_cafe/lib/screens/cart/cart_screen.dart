import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';

import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/cart_Item.dart';

import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';

import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/cart/subviews/card_item_view.dart';

import '../../model/menu_item.dart';
import '../../reusable_components/buttons/circle_btn.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart, required this.menuItems});
  final List<CartItem> cart;
  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return BlocProvider(
      create: (context) => CartCubit(cart, menuItems),
      child: Builder(builder: (context) {
        final cubit = context.read<CartCubit>();

        return Scaffold(
          backgroundColor: C.bg1(brightness),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: CustomeBackBtn(brightness: brightness),
          ),
          body: SafeArea(
            child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ListView(
                        children: cubit.cartItems
                            .map((cartItem) => CartItemView(
                                cubit: context.read<CartCubit>(),
                                cartItem: cartItem))
                            .toList(),
                      ),
                    ),
                  ),
                  Text('Total: ${cubit.totalPrice()}'),
                  InkWell(
                    onTap: () => cubit.navigateToPayment(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomPaint(
                                  size: Size(0, 90), painter: CircleBtn()),
                            ),
                          ],
                        ),
                        Text('Proceed to Payment').styled(
                            size: 16,
                            color: C.bg1(brightness),
                            weight: FontWeight.bold)
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
