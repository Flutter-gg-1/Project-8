import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/widget/button/custom_button.dart';
import 'package:customer_app/widget/cart_widget/custome_order_list_container.dart';
import 'package:customer_app/widget/cart_widget/custome_text_tow_direction.dart';
import 'package:customer_app/widget/cart_widget/seprate_divider.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD7D1CA),
      appBar: AppBar(
        backgroundColor: const Color(0xffD7D1CA),
        centerTitle: true,
        title: const Text('My Order'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: context.getHeight(multiply: 0.05),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getHeight(multiply: 0.042)),
                    child: Column(
                      children: [
                        TextWithTowDirection(
                          isRightClickable: true,
                          onPressed: () {},
                          leftText: 'Total Order',
                          leftTextColor: Colors.black,
                          leftTextSize: 20,
                          rightText: 'Clear',
                          rightTextColor: const Color(0xffA8483D),
                          rightTextSize: 20,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        SizedBox(
                          height: context.getHeight(multiply: 0.04),
                        ),
                        OrderListContainer(
                          widthMainContainer: context.getWidth(multiply: 0.83),
                          heightMainContainer:
                              context.getHeight(multiply: 0.12),
                          colorMainContainer: const Color(0xff87B1C5),
                          orderImage: 'assets/image/menu1.png',
                          widthLine: context.getWidth(multiply: 0.01),
                          heightLine: context.getHeight(multiply: 0.085),
                          colorLine: const Color(0xff3D6B7D),
                          widthQuantityContainer:
                              context.getWidth(multiply: 0.09),
                          heightQuantityContainer:
                              context.getHeight(multiply: 0.04),
                          colorQuantityContainer: const Color(0xffEFE3C8),
                          colorDeleteIcon: const Color(0xffA8483D),
                          orderText: 'Latte',
                          orderTextSize: 20,
                          quantityText: 2,
                          quantityTextSize: 23,
                          textPrice: '19',
                          onPressedAddQuantity: () {},
                          onPressedDeleteOrder: () {},
                          onPressedMinusQuantity: () {},
                        ),
                        SizedBox(
                          height: context.getHeight(multiply: 0.01),
                        ),
                        SeparatorDivider(
                          color: Colors.black.withOpacity(0.60),
                          height: 2,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Order Summary',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
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
                        SizedBox(
                          height: context.getHeight(multiply: 0.01),
                        ),
                        SeparatorDivider(
                          color: Colors.black.withOpacity(0.60),
                          height: 2,
                        ),
                        SizedBox(
                          height: context.getHeight(multiply: 0.02),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Non-scrollable content
          Container(
            width: double.infinity,
            height: context.getHeight(multiply: 0.215),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                color: Color(0xffD9D9D9)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.getHeight(multiply: 0.03),
                  vertical: context.getHeight(multiply: 0.02)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const TextWithTowDirection(
                      leftText: 'Total',
                      rightText: '500 RS',
                      leftTextSize: 20,
                      rightTextSize: 20,
                      leftTextColor: Colors.black,
                      rightTextColor: Colors.black,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      isRightClickable: false),
                  CustomButton(
                    title: 'CheckOut',
                    onPressed: () {},
                    icon: Icons.arrow_forward_ios_rounded,
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
