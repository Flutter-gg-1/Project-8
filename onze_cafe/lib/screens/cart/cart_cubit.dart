import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/model/cart_Item.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final List<CartItem> cartItems = [];

  void addItem(CartItem item) {
    cartItems.add(item);
    emit(CartUpdatedState(cartItems));
  }

  void removeItem(CartItem item) {
    cartItems.remove(item);
    emit(CartUpdatedState(cartItems));
  }
}
