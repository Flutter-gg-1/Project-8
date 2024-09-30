import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/placed_order.dart';
import 'package:onze_cafe/screens/order/order_cubit.dart';

class OrderCardView extends StatelessWidget {
  const OrderCardView({
    super.key,
    required this.cubit,
    required this.placedOrder,
    required this.brightness,
  });

  final OrderCubit cubit;
  final PlacedOrder placedOrder;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final cartItems = cubit.fetchCartItems(placedOrder);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AspectRatio(
        aspectRatio: 3,
        child: InkWell(
          onTap: () => cubit.navigateToOrderDetails(context),
          child: Card(
              color: C.bg3(brightness),
              elevation: 4,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image(image: Img.logo4, fit: BoxFit.contain)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 5),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Order# ${placedOrder.id}')
                                    .styled(weight: FontWeight.bold, size: 18),
                                Row(
                                    children: cartItems
                                        .map((cartItem) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                              child: Text(cubit
                                                          .fetchMenuItem(
                                                              cartItem)
                                                          ?.name ??
                                                      '')
                                                  .styled(size: 12),
                                            ))
                                        .toList())
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text("${cubit.totalPrice(placedOrder)} SAR")
                                  .styled(weight: FontWeight.bold, size: 16)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Icon(Icons.arrow_forward_ios_rounded)),
                ],
              )),
        ),
      ),
    );
  }
}
