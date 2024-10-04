import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  late final RealtimeChannel channel;
  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEvent>(loadOrders);
    on<LoadNewOrderEvent>(loadNewOrder);
    on<ReadyEvent>(setReady);
    on<CancelEvent>(setCancel);

    initializeListener();
  }

  void initializeListener() async {
  channel = supabase
      .channel('public:order_item')
      .onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'order_item',
        callback: (payload) async {
          if (payload.newRecord.isNotEmpty) {
            final orderItemId = payload.newRecord['item_id'];

            final response = await supabase
                .from('order_item')
                .select('*, orders(*), item(*)')
                .eq('item_id', orderItemId)
                .maybeSingle();

            final newItem = response;

            log('Full record: $newItem');
            await Future.delayed(const Duration(seconds: 1));

            add(LoadNewOrderEvent(order: newItem!));
          } else {
            log('Empty newRecord received.');
          }
        },
      )
      .subscribe();
}


  @override
  Future<void> close() async {
    await supabase.removeChannel(channel);
    return super.close();
  }

  FutureOr<void> loadOrders(
      LoadEvent event, Emitter<EmployeeState> emit) async {
    try {
      emit(LoadingState());
      final orders = await fetchAllOrders();
      if (orders.isNotEmpty) {
        emit(SuccessfullLoadState(orders: orders));
      } else {
        emit(FailedLoadState());
      }
    } catch (error) {
      emit(ErrorState(errorMessage: error.toString()));
    }
  }

  FutureOr<void> loadNewOrder(
      LoadNewOrderEvent event, Emitter<EmployeeState> emit) async {
    locator.get<DataLayer>().orders.add(event.order);
    await Future.delayed(const Duration(seconds: 1));
    add(LoadEvent());
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

  FutureOr<void> setCancel(
      CancelEvent event, Emitter<EmployeeState> emit) async {
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
