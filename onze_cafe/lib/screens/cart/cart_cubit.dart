import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';
import 'package:onze_cafe/model/menu_item.dart';
import 'package:onze_cafe/screens/checkout/checkout_screen.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CartItem> cartItems = [];
  int count = 1;

  void fetchCartItems() {
    var allCartItems = MockData().cart;
    cartItems =
        allCartItems.where((item) => item.placedOrderId == null).toList();

    emit(CartUpdatedState(cartItems));
  }

  MenuItem? fetchMenuItem(String menuItemId) {
    var menuItems = MockData().menuItems;
    return menuItems
        .where((menuItem) => menuItem.id == menuItemId)
        .toList()
        .firstOrNull;
  }

  void addItem(CartItem item) {
    cartItems.add(item);
    emit(CartUpdatedState(cartItems));
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    emit(CartUpdatedState(cartItems));
  }

  void incrementCount(CartItem item) {
    if (item.quantity < 10) {
      item.quantity++;
      emit(CartUpdatedState(cartItems));
    }
  }

  void decrementCount(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
      emit(CartUpdatedState(cartItems));
    }
  }
  void navigateToPayment(BuildContext context) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const CheckoutScreen()));
}
