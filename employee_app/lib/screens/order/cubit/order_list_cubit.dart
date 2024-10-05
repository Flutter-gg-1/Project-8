import 'dart:async';
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
  Timer? _timer;
  int _tickCount = 0;
  int statusIndex = 0;
  showOrderList() async {
    try {
      log("here");
      await Future.delayed(const Duration(milliseconds: 300));

      log("after");

      orderList.clear();
      final orders = await SuperMain().getCustumersOrders();

      for (var val in orders) {
        orderList.add(OrderModel.fromJson(val));
      }
      orderList.forEach(
        (element) => log('${element.toJson()}'),
      );
      for (var val in orderList) {
        final OrderDetailRes =
            await SuperMain().getAllUserOrder(orderId: val.orderId!);

        for (var lisVal in OrderDetailRes) {
          val.orderDetailsLis.add(OrderDetailsModel.fromJson(lisVal));
        }
      }


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

  void startTimer() {
    emit(TimerRunInProgress(tickCount: _tickCount));
    trackStatusChange();
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 40), (timer) {
      trackStatusChange();
    });
  }

  Future<void> trackStatusChange() async {
    try {
      await showOrderList();
      emit(TimerRunInProgress(tickCount: _tickCount));
    } catch (e) {
      emit(ErorrState(msg: 'Order status is not available'));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
