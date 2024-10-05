import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/checkout/checkout_screen.dart';

import '../../reusable_components/animated_snackbar.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(List<CartItem> cart, List<MenuItem> menuItems)
      : super(CartInitial()) {
    initialLoad(cart, menuItems);
  }
  List<CartItem> cartItems = [];
  List<MenuItem> menuItems = [];

  void initialLoad(List<CartItem> cart, List<MenuItem> menuItems) {
    cartItems = cart; // Explicitly refer to the class-level cartItems
    this.menuItems = menuItems; // Explicitly refer to the class-level menuItems
    emitUpdate();
  }

  MenuItem? fetchMenuItem(String menuItemId) {
    return menuItems
        .where((menuItem) => menuItem.id == menuItemId)
        .toList()
        .firstOrNull;
  }

  void incrementCount(CartItem item) {
    if (item.quantity < 10) {
      item.quantity++;
      emitUpdate();
    }
  }

  double totalPrice() {
    var total = 0.0;
    for (var cartItem in cartItems) {
      var quantity = cartItem.quantity;
      var item = fetchMenuItem(cartItem.menuItemId);
      if (item != null) {
        total += item.price * quantity;
      }
    }
    return total;
  }

  void decrementCount(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      emitUpdate();
    }
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void navigateToPayment(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CheckoutScreen(totalPrice: totalPrice())));

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
