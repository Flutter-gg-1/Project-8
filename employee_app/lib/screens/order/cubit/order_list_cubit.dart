import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employee_app/DB/super_main.dart';
import 'package:employee_app/models/order_details_model.dart';
import 'package:employee_app/models/order_model.dart';

import 'package:meta/meta.dart';

part 'order_list_state.dart';

class OrderListCubit extends Cubit<OrderListState> {
  OrderListCubit() : super(OrderListInitial());

  List<OrderModel> orderList = [];

  showOrderList() async {
    try {
      log("here");
      await Future.delayed(const Duration(milliseconds: 300));
      emit(LoadingState());
      log("after");

      orderList.clear();
      final orders = await SuperMain().getCustumersOrders();

      for (var val in orders) {
        orderList.add(OrderModel.fromJson(val));
      }

      for (var val in orderList) {
        final OrderDetailRes =
            await SuperMain().getAllUserOrder(orderId: val.orderId!);

        for (var lisVal in OrderDetailRes) {
          val.orderDetailsLis.add(OrderDetailsModel.fromJson(lisVal));
        }
      }

      print(orderList[0].orderDetailsLis);
      emit(NoLodingState());
      emit(OrderShowState());
    } catch (er) {
      log("$er");
      emit(ErorrState(msg: "there was eorr"));
    }
  }

  changeStatus({required String status, required String orderId}) async {
    try {
      emit(LoadingState());
      await SuperMain().orderChangeStatus(status: status, orderId: orderId);
      emit(NoLodingState());
      showOrderList();
    } catch (er) {
      log("$er");
      emit(ErorrState(msg: "there was eorr"));
    }
  }
}
