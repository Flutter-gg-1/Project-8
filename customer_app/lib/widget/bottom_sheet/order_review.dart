import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderReview extends StatelessWidget {
  const OrderReview({
    super.key,
    required this.order,
    required this.time,
    required this.totalPreparationTime,
    required this.totalPrice,
  });

  final String order;
  final DateTime time;
  final int totalPreparationTime;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            height: context.getHeight(multiply: 0.35),
            width: context.getWidth(multiply: 1),
            padding: EdgeInsets.symmetric(
                horizontal: context.getWidth(multiply: 0.05),
                vertical: context.getHeight(multiply: 0.05)),
            decoration: const BoxDecoration(
                color: Color(0xffeeedea),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Summary',
                  style: TextStyle(
                      color: Color(0xffA8483D),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rosarivo'),
                ),
                const Divider(),
                context.addSpacer(multiply: 0.02),
                Text(
                  'Order Time : $time',
                  style: const TextStyle(
                      color: Color(0xffA8483D),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rosarivo'),
                ),
                context.addSpacer(multiply: 0.01),
                Text(
                  'Preparation Time : $totalPreparationTime',
                  style: const TextStyle(
                      color: Color(0xffA8483D),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rosarivo'),
                ),
                context.addSpacer(multiply: 0.01),
                Text(
                  'Total Price : $totalPrice RS',
                  style: const TextStyle(
                      color: Color(0xffA8483D),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rosarivo'),
                ),
                const Spacer(),
                const Center(
                  child: Text(
                    'Enjoy',
                    style: TextStyle(
                        color: Color(0xffA8483D),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rosarivo'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      title: const Text(
        'Review Your Order',
        style: TextStyle(
            color: Color(0xffEFE3C8),
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'Rosarivo'),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: Colors.white,
      ),
    );
  }
}
