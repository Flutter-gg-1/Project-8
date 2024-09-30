import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/order/order_cubit.dart';

class OrderCardView extends StatelessWidget {
  const OrderCardView({
    super.key,
    required this.cubit,
    required this.brightness,
  });

  final OrderCubit cubit;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image(image: Img.late, fit: BoxFit.fill)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 5),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text("20 SAR")
                                .styled(weight: FontWeight.bold, size: 16),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("#101")
                                  .styled(weight: FontWeight.bold, size: 18),
                              Text("espresso, americano").styled(),
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
