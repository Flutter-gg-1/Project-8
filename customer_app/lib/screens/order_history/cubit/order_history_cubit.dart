import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:customer_app/models/order_details_model.dart';
import 'package:customer_app/models/order_model.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:meta/meta.dart';

part 'order_history_state.dart';

class OrderShowCubit extends Cubit<OrderShowState> {
  OrderShowCubit() : super(OrderHistoryInitial());
  String orderStatus = 'Pending';
  String? orderId = '062a8cfc-deb9-4cd6-9c00-e7af246cfce3';
  List<OrderModel> orderList = [];
  Timer? _timer;
  int _tickCount = 0;
  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _onTick();
    });
  }

  Future<void> _onTick() async {
    try {
      var status = await SuperMain().supabase
          .from('orders')
          .select('status')
          .eq('order_id', orderId ?? '062a8cfc-deb9-4cd6-9c00-e7af246cfce3');

      _tickCount++;

      log('${status[0]}');
      orderStatus = '${status[0]['status']}';
    } catch (e) {
      log('$e');
    }
    emit(TimerRunInProgress(tickCount: _tickCount));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  getAllUserOrder({String? status}) async {
    try {
      log('-----01');
      emit(LoadingState());
      orderList.clear();
      final res = await SuperMain().getUserOrder(status: status);
      log('--------02');
      log("$res");
      emit(SuccessState());
      for (var val in res) {
        orderList.add(OrderModel.fromJson(val));
      }
      log('--------03');
      for (var val in orderList) {
        final orderRes =
            await SuperMain().getAllUserOrderDetail(orderId: val.orderId!);

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
      emit(ErrorState(msg: 'Sorry there is some problem try it later'));
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
