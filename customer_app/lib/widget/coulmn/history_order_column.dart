import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/order_history/cubit/order_history_cubit.dart';
import 'package:customer_app/widget/cart_widget/custome_text_tow_direction.dart';
import 'package:customer_app/widget/cart_widget/seprate_divider.dart';
import 'package:flutter/material.dart';

class HistoryOrderColumn extends StatelessWidget {
  const HistoryOrderColumn({
    super.key,
    required this.cubit,
    required this.index,
  });

  final OrderShowCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cubit.orderList[index].orderDetailsLis.length,
          itemBuilder: (context, index2) {
            return Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/image/menu1.png",
                      height: context.getHeight(multiply: 0.08),
                    ),
                    SizedBox(
                      width: context.getWidth(multiply: 0.015),
                    ),
                    Container(
                      width: context.getWidth(multiply: 0.01),
                      height: context.getHeight(multiply: 0.085),
                      decoration: const BoxDecoration(
                          color: Color(0xff3D6B7D),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                    SizedBox(
                      width: context.getWidth(multiply: 0.02),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.orderList[index].orderDetailsLis[index2]
                                .productModel!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            cubit.orderList[index].orderDetailsLis[index2]
                                    .productModel!.des ??
                                "",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.50),
                            ),
                          ),
                          SizedBox(
                            height: context.getWidth(multiply: 0.02),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            "x${cubit.orderList[index].orderDetailsLis[index2].quantity}"),
                        Text(
                            ' ${cubit.orderList[index].orderDetailsLis[index2].productModel!.price! * cubit.orderList[index].orderDetailsLis[index2].quantity!}'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: index2 < cubit.orderList.length - 1
                        ? context.getWidth(multiply: 0.02)
                        : 0),
              ],
            );
          },
        ),
        SizedBox(
          height: context.getWidth(multiply: 0.02),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SeparatorDivider(
              color: Colors.black.withOpacity(0.60),
              height: 2,
            ),
            TextWithTowDirection(
              isRightClickable: false,
              onPressed: () {},
              leftText: 'Total',
              leftTextColor: Colors.black,
              leftTextSize: 20,
              rightText: '${cubit.getTotalQueAndPrice(index: index)}',
              rightTextColor: Colors.black.withOpacity(0.40),
              rightTextSize: 20,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ],
        ),
      ],
    );
  }
}
