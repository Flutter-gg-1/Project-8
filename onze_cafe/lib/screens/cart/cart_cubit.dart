import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  List<CartItem> cartItems = [];
  int count = 1;

  void fetchCartItems() {
    var menuItems = MockData().menuItems;
    cartItems = MockData().cart;
    for (var item in cartItems) {
      item.menuItem = menuItems
          .where((menuItem) => menuItem.id == item.menuItemId)
          .toList()
          .firstOrNull;
    }
    emit(CartUpdatedState(cartItems));
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
}
