import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/image/logo.png'),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Color(0xff87B1C5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.getWidth(multiply: 0.1),
                      vertical: context.getHeight(multiply: 0.03)),
                  child: Column(
                    children: [
                      Text(
                        '${product.name}',
                        style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rosarivo'),
                      ),

                      ///==============================
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${product.des}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rosarivo',
                                  color: Color(0x60000000)),
                            ),
                            const Divider(),
                            context.addSpacer(multiply: 0.02),
                            Text(
                              'Cal : ${product.cal}',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffA8483D),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rosarivo'),
                            ),
                            context.addSpacer(multiply: 0.02),
                            Text(
                              'preparation Time : ${product.preparationTime}',
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xffA8483D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            context.addSpacer(multiply: 0.02),
                            Text(
                              'Price : ${product.price} RS',
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffA8483D),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Rosarivo'),
                            ),
                            context.addSpacer(multiply: 0.02),
                          ],
                        ),
                      ),
                      const Divider(),
                      const Text(
                        'Size',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rosarivo',
                            color: Color(0xffA8483D)),
                      ),
                      CustomRadioButton(
                        elevation: 0,
                        unSelectedBorderColor: const Color(0xff87B1C5),
                        unSelectedColor: const Color(0xffEFE3C8), //A8483D
                        buttonLables: const [
                          'S',
                          'M',
                          'L',
                        ],
                        buttonValues: const [
                          "S",
                          "M",
                          "L",
                        ],
                        buttonTextStyle: const ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 16)),
                        radioButtonValue: (value) {
                          print(value);
                        },
                        selectedColor: const Color(0xffA8483D),
                      ),
                      context.addSpacer(multiply: 0.04),
                      const Divider(),
                      const Text(
                        'Quantity',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rosarivo',
                            color: Color(0xffA8483D)),
                      ),
                      context.addSpacer(multiply: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.minus_square_bold,
                                color: Color(0xffEFE3C8),
                                size: 35,
                              )),
                          Text(
                            ' 1 ',
                            style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rosarivo'),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.add_square_bold,
                                color: Color(0xffEFE3C8),
                                size: 35,
                              )),
                        ],
                      ),
                      context.addSpacer(multiply: 0.04),
                      CustomButton(
                        title: 'Add to Cart',
                        onPressed: () {},
                        icon: Iconsax.shop_add_bold,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
