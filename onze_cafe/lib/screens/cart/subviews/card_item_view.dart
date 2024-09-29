import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/reusable_components/count_view.dart';
import 'package:onze_cafe/screens/cart/cart_cubit.dart';

class CartItemView extends StatelessWidget {
  final CartCubit cubit;
  final CartItem item;

  const CartItemView({
    super.key,
    required this.cubit,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AspectRatio(
        aspectRatio: 3,
        child: Card(
            color: C.bg3(brightness),
            elevation: 4,
            child: Stack(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(image: Img.late, fit: BoxFit.fill)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name)
                                .styled(weight: FontWeight.bold, size: 18),
                            Text("${item.price} SAR")
                                .styled(weight: FontWeight.bold, size: 16),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CountView(
                          color: C.primary(brightness),
                          fSize: 20,
                          size: 20,
                          count: 1,
                          onDecrement: () => cubit.decrementCount(item),
                          onIncrement: () => cubit.incrementCount(item),
                        )),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
