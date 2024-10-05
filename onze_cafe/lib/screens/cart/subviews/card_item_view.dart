import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/reusable_components/count_view.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';
import 'package:onze_cafe/screens/cart/network_functions.dart';

class CartItemView extends StatelessWidget {
  final CartCubit cubit;
  final CartItem cartItem;

  const CartItemView({
    super.key,
    required this.cubit,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final menuItem = cubit.fetchMenuItem(cartItem.menuItemId);

    return Card(
        color: C.bg3(brightness),
        elevation: 4,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: menuItem?.imgUrl == null
                        ? Image(image: Img.logo4, fit: BoxFit.fill)
                        : Image.network(menuItem!.imgUrl!,
                            fit: BoxFit.contain)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(menuItem?.name ?? '')
                        .styled(weight: FontWeight.bold, size: 16),
                    Row(children: [
                      Text(cartItem.milkOption ?? '')
                          .styled(weight: FontWeight.w300, size: 12),
                      const SizedBox(width: 4),
                      Text(cartItem.coffeeStrength ?? '').styled(
                          weight: FontWeight.w300, size: 10, lineLimit: 1),
                    ]),
                    Text("${menuItem?.price ?? 0} SAR")
                        .styled(weight: FontWeight.bold, size: 14),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () => cubit.removeCartItem(context, cartItem),
                    icon: Icon(
                      CupertinoIcons.trash_circle_fill,
                      color: C.secondary(brightness),
                    )),
                CountView(
                  fColor: C.primary(brightness),
                  fSize: 20,
                  iconSize: 30,
                  iconColor: C.primary(brightness),
                  count: cartItem.quantity,
                  onDecrement: () => cubit.decrementCount(cartItem),
                  onIncrement: () => cubit.incrementCount(cartItem),
                ),
              ],
            ),
          ],
        ));
  }
}
