import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:meta/meta.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());

  List<OrderModel> orderList = [];

  getAllUserOrder() async {
    try {
      final res = await SuperMain().getUserOrderHistory();

      log("$res");

      for (var val in res) {
        orderList.add(OrderModel.fromJson(val));
      }

      for (var val in orderList) {
        final orderRes =
            await SuperMain().getAllUserOrder(orderId: val.orderId!);

        log("$orderRes");

        for (var orderVal in orderRes) {
          OrderDetailsModel temp = OrderDetailsModel.fromJson(orderVal);

          temp.productModel = ProductModel.fromJson(
              await SuperMain().getProductById(productId: temp.productId));

          val.orderDetailsLis.add(temp);
        }
      }

      emit(OrderHistoryShowDataState());
    } catch (er) {
      log("err is in the cubit");
      log("$er");
    }
  }

  getTotalQueAndPrice({required int index}) {
    int totalQue = 0;

    for (var val in orderList[index].orderDetailsLis) {
      totalQue += val.quantity ?? 0;
    }

    return "X$totalQue ${orderList[index].totalPrice} SAR";
  }
}
