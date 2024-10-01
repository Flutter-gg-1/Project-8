import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/data_layer/auth_layer.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/screens/auth/cubit/auth_cubit/auth_cubit.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meta/meta.dart';
import 'package:moyasar/moyasar.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<OrderDetailsModel> cartLis = productLocator.get<ProductLayer>().cartItem;

  double priceTotal = 0;
  int totalPreTime = 0;

  CartCubit() : super(CartInitial());

  showCart() {
    getAllTotal();
    emit(ShowCartState());
  }

  addQue({required OrderDetailsModel orderModel}) {
    orderModel.quantity = orderModel.quantity! + 1;
    getAllTotal();
    emit(QueChangeState());
  }

  minusQue({required OrderDetailsModel orderModel}) {
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

  buyCart() async {
    if (cartLis.isEmpty) {
      emit(ErorrState(msg: "the Cart is emty"));
      return;
    }

    await dotenv.load(fileName: ".env");

    try {
      final paymentConfig = PaymentConfig(
        publishableApiKey: dotenv.env['moyster_key']!,
        amount: (priceTotal * 100).toInt(), // SAR 257.58
        description: 'order #1324',

        creditCard: CreditCardConfig(saveCard: true, manual: false),
      );

      emit(OrderConformState(paymentConfig: paymentConfig));
    } catch (er) {
      log("$er");
    }
  }

  checkOut({required PaymentResponse paymentResponse}) async {
    if (paymentResponse.status == PaymentStatus.paid) {
      final orderId = await SuperMain().palceOrder(
          customerId: productLocator.get<AuthLayer>().user!.customerId,
          totalPrice: priceTotal,
          totalPreTime: totalPreTime);

      await SuperMain().insetCartData(orderId: orderId, cartLis: cartLis);

      emit(BuySucssState(msg: "you buy succs"));
    } else if (paymentResponse.status == PaymentStatus.failed) {
      emit(ErorrState(msg: "buy faild"));
      return;
    }
  }
}
