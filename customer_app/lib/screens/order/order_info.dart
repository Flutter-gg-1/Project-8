import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/screens/order/bloc/order_bloc.dart';
import 'package:customer_app/services/setup.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/coulmn/order_details.dart';
import 'package:customer_app/widget/row/quantity_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<OrderBloc>();
        final locator = productLocator.get<ProductLayer>();
        String size = 'S';
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
                          OrderDetails(product: product),
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
                            selectedBorderColor: const Color(0xff87B1C5),
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
                              size = value;
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
                          QuantityRow(bloc: bloc),
                          context.addSpacer(multiply: 0.04),
                          CustomButton(
                            title: 'Add to Cart',
                            onPressed: () async {

  
                              locator.cartItem.add(OrderDetailsModel(
                                productModel: product,

                              locator.cartItem.add(OrderDetailsModel(

                                productId: product.productId,
                                quantity: bloc.quantity,
                                size: size,
                              ));
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    width: context.getHeight(multiply: 0.4),
                                    height: context.getHeight(multiply: 0.3),
                                    decoration: BoxDecoration(
                                        color: Color(0xffEFE3C8),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(
                                      child: Text(
                                        'Thank You\nItem have been add to cart',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Rosarivo',
                                            color: Color(0xffA8483D)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              await Future.delayed(
                                const Duration(seconds: 2),
                                () {
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    log('${locator.cartItem.first.toJson()}');
                                  }
                                },
                              );
                            },
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
      }),
    );
  }
}
