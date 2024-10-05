import 'package:employee_app/helper/extinsion/order_date_format.dart';
import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/order_model.dart';
import 'package:employee_app/screens/order/cubit/order_list_cubit.dart';
import 'package:employee_app/screens/order/order_status.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  final OrderListCubit cubit;
  final Function()? onTap;
  const OrderItem({
    super.key,
    required this.order,
    this.onTap,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: context.getWidth(multiply: 0.01),
            vertical: context.getHeight(multiply: 0.01)),
        padding: EdgeInsets.symmetric(
            horizontal: context.getWidth(multiply: 0.01),
            vertical: context.getHeight(multiply: 0.01)),
        height: context.getHeight(multiply: 0.14),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: kElevationToShadow[4],
            color: const Color(0xffeeedea)),
        child: Row(
          children: [
            Image.asset(
              'assets/image/appBarProfile (2).png',
              filterQuality: FilterQuality.high,
            ),
            const VerticalDivider(
              color: Color(0xff3D6B7D),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Iconsax.profile_2user_outline,
                      color: Color(0xff3D6B7D),
                    ),
                    Text(
                      'User name',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.timer_1_bold,
                      color: Color(0xff3D6B7D),
                    ),
                    Text(
                      '${order.totalPreparationTime}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rosarivo'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.integration_instructions_outlined),
                    Text(
                      '${order.orderId?.substring(order.orderId!.length - 4, order.orderId?.length)}',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Rosarivo'),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: context.getWidth(multiply: 0.15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: kElevationToShadow[4],
                      color: const Color(0xffEFEDEA)),
                  child: Text(
                    order.time != null
                        ? context.formatOrderTime(timeAsString: order.time!)
                        : 'No time',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Rosarivo'),
                  ),
                ),
                order.status == "Pending"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await cubit.changeStatus(
                                    status: "Preparing",
                                    orderId: order.orderId!);
                              },
                              icon: const Icon(
                                Icons.task_alt_rounded,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () async {
                                await cubit.changeStatus(
                                    status: "Cancelled",
                                    orderId: order.orderId!);
                              },
                              icon: const Icon(
                                Icons.do_disturb_rounded,
                                color: Colors.red,
                              )),
                        ],
                      )
                    : CustomButton(
                        fixedSize: Size(context.getWidth(multiply: 0.2),
                            context.getHeight(multiply: 0.03)),
                        title: "show state",
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              // here chnage
                              return OrderStatus(
                                  order: order.orderDetailsLis.first);
                            },
                          ));
                        },
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
