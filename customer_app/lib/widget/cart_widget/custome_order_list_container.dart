import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:flutter/material.dart';

class OrderListContainer extends StatelessWidget {
  const OrderListContainer({
    super.key,
    required this.widthMainContainer,
    required this.heightMainContainer,
    required this.colorMainContainer,
    required this.orderImage,
    required this.widthLine,
    required this.heightLine,
    required this.colorLine,
    required this.orderTextSize,
    required this.widthQuantityContainer,
    required this.heightQuantityContainer,
    required this.colorQuantityContainer,
    this.onPressedMinusQuantity,
    this.onPressedAddQuantity,
    required this.quantityText,
    required this.quantityTextSize,
    this.onPressedDeleteOrder,
    required this.colorDeleteIcon,
    required this.orderModel,
  });

// the model

  final OrderDetailsModel orderModel;

  //main Container
  final double widthMainContainer;
  final double heightMainContainer;
  final Color colorMainContainer;
  //image and line side
  final String orderImage;
  final double widthLine;
  final double heightLine;
  final Color colorLine;
  //order

  final double orderTextSize;
  //quantity
  final double widthQuantityContainer;
  final double heightQuantityContainer;
  final Color colorQuantityContainer;
  final void Function()? onPressedMinusQuantity;
  final void Function()? onPressedAddQuantity;
  final int quantityText;
  final double quantityTextSize;
  //delete
  final void Function()? onPressedDeleteOrder;
  final Color colorDeleteIcon;
  //text Price

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthMainContainer,
      height: heightMainContainer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: colorMainContainer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                orderImage,
              ),
              Container(
                width: widthLine,
                height: heightLine,
                decoration: BoxDecoration(
                    color: colorLine,
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
              ),
              SizedBox(
                width: context.getWidth(multiply: 0.02),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.getWidth(multiply: 0.02),
                  ),
                  Text(
                    orderModel.productModel!.name!,
                    style: TextStyle(fontSize: orderTextSize),
                  ),
                  SizedBox(
                    height: context.getWidth(multiply: 0.02),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: widthQuantityContainer,
                        height: heightQuantityContainer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorQuantityContainer,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: onPressedMinusQuantity,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            icon: const Icon(Icons.remove),
                          ),
                        ),
                      ),
                      SizedBox(width: context.getWidth(multiply: 0.02)),
                      Text(
                        '${orderModel.quantity}',
                        style: TextStyle(fontSize: quantityTextSize),
                      ),
                      SizedBox(width: context.getWidth(multiply: 0.02)),
                      Container(
                        width: widthQuantityContainer,
                        height: heightQuantityContainer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorQuantityContainer,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: onPressedAddQuantity,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            icon: const Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: onPressedDeleteOrder,
                  icon: Icon(
                    Icons.delete_outline,
                    color: colorDeleteIcon,
                  )),
              Row(
                children: [
                  Text(
                    '${orderModel.productModel!.price! * orderModel.quantity!} SAR',
                    style: TextStyle(color: Colors.black.withOpacity(0.50)),
                  ),
                  SizedBox(
                    width: context.getWidth(multiply: 0.02),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
