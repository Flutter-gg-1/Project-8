import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/order_details_model.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:employee_app/widget/button/home_button.dart';
import 'package:flutter/material.dart';

import '../../shape/draw_dotted_line.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key, required this.order});
  final OrderDetailsModel order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/image/status_cup.png'),
            context.addSpacer(multiply: 0.02),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getWidth(multiply: 0.05)),
              width: context.getWidth(multiply: 0.9),
              height: context.getHeight(multiply: 0.4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xffD7D1CA),
                  boxShadow: kElevationToShadow[4]),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  const Text('20 min',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                  const Text('Ordering.....',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3D6B7D),
                          fontFamily: 'Rosarivo')),
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color(0xff3D6B7D),
                      ),
                      Text('Basel alalawi',
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins')),
                      Spacer(),
                      Icon(Icons.integration_instructions_outlined,
                          color: Color(0xff3D6B7D)),
                      Text('1239',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rosarivo')),
                    ],
                  ),
                  const Divider(),
                  context.addSpacer(multiply: 0.02),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: Color(0xff3D6B7D),
                      ),
                      Text(
                          '------------------------------------------------------'),
                      Text('6/28',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rosarivo')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Color(0xff3D6B7D),
                      ),
                      const Text(
                          '------------------------------------------------------'),
                      Text('${order.productModel?.name}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rosarivo')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Color(0xff3D6B7D),
                      ),
                      const Text(
                          '------------------------------------------------------'),
                      Text('${order.size}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rosarivo')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.date_range_outlined,
                        color: Color(0xff3D6B7D),
                      ),
                      const Text(
                          '------------------------------------------------------'),
                      Text('${order.quantity}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Rosarivo')),
                    ],
                  ),
                  context.addSpacer(multiply: 0.02),
                  const Divider(),
                  context.addSpacer(multiply: 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomButton(
                        title: '     Delver',
                        onPressed: () {},
                        fixedSize: Size(context.getWidth(multiply: 0.37),
                            context.getHeight(multiply: 0.05)),
                      ),
                      const Spacer(),
                      CustomButton(
                        title: '  Ready',
                        onPressed: () {},
                        fixedSize: Size(context.getWidth(multiply: 0.37),
                            context.getHeight(multiply: 0.05)),
                      ),
                    ],
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
