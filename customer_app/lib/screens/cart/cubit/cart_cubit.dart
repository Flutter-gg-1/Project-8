import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<OrderModel> cartLis = productLocator.get<ProductLayer>().cartItem;

  double priceTotal = 0;
  int totalPreTime = 0;

  CartCubit() : super(CartInitial());

  showCart() {
    getAllTotal();
    emit(ShowCartState());
  }

  addQue({required OrderModel orderModel}) {
    orderModel.quantity = orderModel.quantity! + 1;
    getAllTotal();
    emit(QueChangeState());
  }

  minusQue({required OrderModel orderModel}) {
    if (orderModel.quantity != 1) {
      orderModel.quantity = orderModel.quantity! - 1;
      getAllTotal();
      emit(QueChangeState());
    }
  }

  delOrder({required int index}) {
    cartLis.removeAt(index);

    getAllTotal();

    emit(DelOrderState());
  }

  getAllTotal() {
    priceTotal = 0;
    totalPreTime = 0;
    for (var val in cartLis) {
      int que = val.quantity!;

      priceTotal += val.productModel!.price! * que;
      totalPreTime += val.quantity!;
    }
  }

  checkOut() async {
    if (cartLis.isEmpty) {
      emit(ErorrState(msg: "the Cart is emty"));
      return;
    }

    final orderId = await SuperMain().palceOrder(
        customerId: productLocator.get<AuthLayer>().user!.customerId,
        totalPrice: priceTotal,
        totalPreTime: totalPreTime);

    await SuperMain().insetCartData(orderId: orderId, cartLis: cartLis);
  }
}
