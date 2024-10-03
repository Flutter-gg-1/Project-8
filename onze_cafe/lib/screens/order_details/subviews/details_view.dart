import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/placed_order.dart';
import 'package:onze_cafe/screens/order_details/order_details_cubit.dart';

class DetailsViwe extends StatelessWidget {
  const DetailsViwe({
    super.key,
    required this.cubit,
    required this.placedOrder,
    required this.brightness,
    required this.price,
  });

  final Brightness brightness;
  final OrderDetailsCubit cubit;
  final PlacedOrder placedOrder;
  final double price;

  @override
  Widget build(BuildContext context) {
    final cartItems = cubit.fetchCartItems(placedOrder);

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: G.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.all(24),
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: C.bg1(brightness)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Text('Order# ${placedOrder.id}').styled(
                    weight: FontWeight.bold,
                    size: 24,
                    color: C.bg1(brightness)),
                SingleChildScrollView(
                  child: Column(
                      children: cartItems
                          .map((cartItem) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${cubit.fetchMenuItem(cartItem)?.name ?? ''} x${cartItem.quantity}")
                                        .styled(
                                      size: 16,
                                      color: C.bg1(
                                        brightness,
                                      ),
                                      weight: FontWeight.w700,
                                    ),
                                    Text("${cubit.fetchMenuItem(cartItem)?.price} SAR")
                                        .styled(
                                      size: 16,
                                      color: C.bg1(
                                        brightness,
                                      ),
                                      weight: FontWeight.w800,
                                    ),
                                  ],
                                ),
                              ))
                          .toList()),
                ),
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Price").styled(
                        weight: FontWeight.bold,
                        size: 24,
                        color: C.bg1(
                          brightness,
                        ),
                      ),
                      Text("$price SAR").styled(
                        weight: FontWeight.bold,
                        size: 24,
                        color: C.bg1(
                          brightness,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
