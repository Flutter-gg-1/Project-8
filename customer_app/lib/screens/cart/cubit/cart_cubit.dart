import 'package:bloc/bloc.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<OrderModel> cartLis = productLocator.get<ProductLayer>().cartItem;

  double priceTotal = 0;

  CartCubit() : super(CartInitial());

  showCart() {
    getTotalPrice();
    emit(ShowCartState());
  }

  addQue({required OrderModel orderModel}) {
    orderModel.quantity = orderModel.quantity! + 1;
    getTotalPrice();
    emit(QueChangeState());
  }

  minusQue({required OrderModel orderModel}) {
    if (orderModel.quantity != 1) {
      orderModel.quantity = orderModel.quantity! - 1;
      getTotalPrice();
      emit(QueChangeState());
    }
  }

  delOrder({required int index}) {
    cartLis.removeAt(index);

    getTotalPrice();

    emit(DelOrderState());
  }

  getTotalPrice() {
    priceTotal = 0;
    for (var val in cartLis) {
      int que = val.quantity!;

      priceTotal += val.productModel!.price! * que;
    }
  }

  checkOut() {
    if (cartLis.isEmpty) {
      emit(ErorState(msg: "the Cart is emty"));
    }
  }
}
