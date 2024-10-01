import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEvent>(loadOrders);
    on<ReadyEvent>(setReady);
    on<CancelEvent>(setCancel);
  }

  FutureOr<void> loadOrders(
      LoadEvent event, Emitter<EmployeeState> emit) async {
    try {
      final orders = locator.get<DataLayer>().orders;
      if (orders.isNotEmpty) {
        emit(SuccessfullLoadState(orders: orders));
      } else {
        emit(ErrorState(errorMessage: 'No orders found'));
      }
    } catch (error) {
      emit(ErrorState(errorMessage: error.toString()));
    }
  }

  FutureOr<void> setReady(ReadyEvent event, Emitter<EmployeeState> emit) async {
    try {
      await markItemAsComplete(
          orderId: event.order['order_id'], itemId: event.order['item']['id']);
      emit(ReadySuccessState());
      locator.get<DataLayer>().orders.remove(event.order);
      add(LoadEvent());
    } catch (error) {
      emit(ErrorState(errorMessage: error.toString()));
    }
  }

  FutureOr<void> setCancel(CancelEvent event, Emitter<EmployeeState> emit) async {
    try {
      await cancelOrderItem(
          orderId: event.order['order_id'], itemId: event.order['item']['id']);
      emit(CancelSuccessState());
      locator.get<DataLayer>().orders.remove(event.order);
      add(LoadEvent());
    } catch (error) {
      emit(ErrorState(errorMessage: error.toString()));
    }
  }
}
