import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/mockData/mock_data.dart';
import 'package:onze_cafe/model/cart_Item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
   List<CartItem> cartItems = [];
  int count = 1;

  void fetchMenuItems() {
    cartItems = MockData().cart;
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
    final index = cartItems.indexOf(item);
    if (index != -1) {
      cartItems[index].count++;
      emit(CartUpdatedState(cartItems));
    }
  }

  void decrementCount(CartItem item) {
    final index = cartItems.indexOf(item);
    if (index != -1 && cartItems[index].count > 1) {
      cartItems[index].count--;
      emit(CartUpdatedState(cartItems));
    }
  }
}
