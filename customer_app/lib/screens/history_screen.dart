import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/widget/cart_widget/custome_text_tow_direction.dart';
import 'package:customer_app/widget/cart_widget/seprate_divider.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'image': 'assets/image/menu1.png',
        'name': 'Latte',
        'description': 'Medium, Caramel',
        'quantity': 'x1',
        'price': '245 RS'
      },
      {
        'image': 'assets/image/menu2.png',
        'name': 'Cappuccino',
        'description': 'Large, Vanilla',
        'quantity': 'x2',
        'price': '300 RS'
      },
      {
        'image': 'assets/image/menu1.png',
        'name': 'Latte',
        'description': 'Medium, Caramel',
        'quantity': 'x1',
        'price': '245 RS'
      },
      {
        'image': 'assets/image/menu2.png',
        'name': 'Cappuccino',
        'description': 'Large, Vanilla',
        'quantity': 'x2',
        'price': '300 RS'
      },
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Order History'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.getHeight(multiply: 0.04)),
            child: Column(
              children: [
                SizedBox(
                  height: context.getHeight(multiply: 0.05),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '2024-2-10',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: context.getWidth(multiply: 0.84),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black26),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getHeight(multiply: 0.017),
                        vertical: context.getWidth(multiply: 0.04)),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var product = products[index];
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      product['image'],
                                      height: context.getHeight(multiply: 0.08),
                                    ),
                                    SizedBox(
                                      width: context.getWidth(multiply: 0.015),
                                    ),
                                    Container(
                                      width: context.getWidth(multiply: 0.01),
                                      height:
                                          context.getHeight(multiply: 0.085),
                                      decoration: const BoxDecoration(
                                          color: Color(0xff3D6B7D),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                    ),
                                    SizedBox(
                                      width: context.getWidth(multiply: 0.02),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product['name'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            product['description'],
                                            style: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.50),
                                            ),
                                          ),
                                          SizedBox(
                                            height: context.getWidth(
                                                multiply: 0.02),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(product['quantity']),
                                        Text(' ${product['price']}'),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: index < products.length - 1
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
                              leftText: 'Cherry Milk Shake',
                              leftTextColor: Colors.black,
                              leftTextSize: 20,
                              rightText: 'x1 245 RS',
                              rightTextColor: Colors.black.withOpacity(0.40),
                              rightTextSize: 20,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        ));
  }
}
