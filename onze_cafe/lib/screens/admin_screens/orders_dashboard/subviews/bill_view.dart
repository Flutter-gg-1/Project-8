import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/gradient_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../../model/cart_Item.dart';
import '../../../../model/menu_item.dart';
import '../../../../model/order.dart';

class BillView extends StatelessWidget {
  const BillView(
      {super.key,
      required this.order,
      required this.cartItems,
      required this.menuItems});
  final Order order;
  final List<CartItem> cartItems;
  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        decoration: BoxDecoration(
          gradient: G.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order #${order.id?.substring(0, 8)}').styled(
                    weight: FontWeight.bold,
                    size: 24,
                    color: C.bg1(brightness)),
                IconButton(
                  icon: Icon(Icons.close, color: C.bg1(brightness)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView(
                  children: cartItems
                      .map((cartItem) => _CartItemDetails(cartItem, menuItems))
                      .toList()),
            ),
            Column(
              children: [
                Divider(
                  color: C.bg1(brightness),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("SubTotal").styled(
                      weight: FontWeight.w600,
                      size: 18,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                    Text("${order.price - (order.price * 0.15)} SAR").styled(
                      weight: FontWeight.w600,
                      size: 18,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax(15%)").styled(
                      weight: FontWeight.w600,
                      size: 18,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                    Text("${order.price * 0.15} SAR").styled(
                      weight: FontWeight.w600,
                      size: 18,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Price").styled(
                      weight: FontWeight.bold,
                      size: 24,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                    Text("${order.price} SAR").styled(
                      weight: FontWeight.bold,
                      size: 24,
                      color: C.bg1(
                        brightness,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _CartItemDetails extends StatelessWidget {
  const _CartItemDetails(this.cartItem, this.menuItems);
  final CartItem cartItem;
  final List<MenuItem> menuItems;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(spreadRadius: 2, blurRadius: 2, color: Colors.black12)
              ],
              color: C.bg3(brightness),
            ),
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.coffee,
                color: C.accent(brightness),
              ),
            )),
        Text("${menuItems.firstWhere((item) => item.id == cartItem.menuItemId).name} X${cartItem.quantity}")
            .styled(
          size: 16,
          color: C.bg1(
            brightness,
          ),
          weight: FontWeight.w700,
        ),
        Text("${menuItems.firstWhere((item) => item.id == cartItem.menuItemId).price * cartItem.quantity} SAR")
            .styled(
          size: 16,
          color: C.bg1(
            brightness,
          ),
          weight: FontWeight.w800,
        ),
      ],
    );
  }
}
