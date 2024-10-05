import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/order.dart';
import 'package:onze_cafe/screens/order_details/order_details_cubit.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({
    super.key,
    required this.cubit,
    required this.placedOrder,
  });

  final OrderDetailsCubit cubit;
  final Order placedOrder;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

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
                    color: C.bg1(brightness),
                    lineLimit: 1),
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
                      Text("${placedOrder.price} SAR").styled(
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
