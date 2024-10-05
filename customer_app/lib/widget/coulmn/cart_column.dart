import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:customer_app/screens/cart/cubit/cart_cubit.dart';
import 'package:customer_app/widget/cart_widget/custome_order_list_container.dart';
import 'package:flutter/material.dart';

class CartColumn extends StatelessWidget {
  const CartColumn({
    super.key,
    required this.cubit,
  });

  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        cubit.cartLis.length,
        (index) {
          return Padding(
            padding:
                const EdgeInsets.only(bottom: 10),
            child: OrderListContainer(
              orderModel: cubit.cartLis[index],
              widthMainContainer: context
                  .getWidth(multiply: 0.83),
              heightMainContainer: context
                  .getHeight(multiply: 0.12),
              colorMainContainer:
                  const Color(0xff87B1C5),
              orderImage:
                  'assets/image/menu1.png',
              widthLine: context.getWidth(
                  multiply: 0.01),
              heightLine: context.getHeight(
                  multiply: 0.085),
              colorLine: const Color(0xff3D6B7D),
              widthQuantityContainer: context
                  .getWidth(multiply: 0.09),
              heightQuantityContainer: context
                  .getHeight(multiply: 0.04),
              colorQuantityContainer:
                  const Color(0xffEFE3C8),
              colorDeleteIcon:
                  const Color(0xffA8483D),
              orderTextSize: 20,
              quantityText: 2,
              quantityTextSize: 23,
              onPressedAddQuantity: () {
                cubit.addQue(
                    orderModel:
                        cubit.cartLis[index]);
              },
              onPressedDeleteOrder: () {
                cubit.delOrder(index: index);
              },
              onPressedMinusQuantity: () {
                cubit.minusQue(
                    orderModel:
                        cubit.cartLis[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
