import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:onze_cafe/services/setup.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  late final RealtimeChannel channel;
  TrackBloc() : super(TrackInitial()) {
    on<ReceivedEvent>(receiveOrder);
    on<PrepareEvent>(prepareOrder);
    on<CheckOrderStatusEvent>(checkOrderStatus);
    on<ReadyEvent>(readyOrder);

    initializeListener();
  }

  FutureOr<void> receiveOrder(ReceivedEvent event, Emitter<TrackState> emit) {
    emit(ReceivedState());
    if(locator.get<DataLayer>().order!.status == 'incomplete'){
    Timer(const Duration(seconds: 2), () {
      if (state is! ReadyState) {
        add(PrepareEvent());
      }
    });
    }
  }

  void initializeListener() async {
    log('Initializing channel for order updates...');
    add(CheckOrderStatusEvent());
    channel = supabase
        .channel('public:orders')
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'orders',
          callback: (payload) {
            log('Change detected: ${payload.toString()}');
            final newStatus = payload.newRecord;
            if (newStatus['status'] == 'complete') {
              log('Order marked as complete. Emitting ReadyEvent...');
              add(ReadyEvent());
            }
          },
        )
        .subscribe();

    log('Channel initialization complete.');
  }

  @override
  Future<void> close() async {
    await supabase.removeChannel(channel);
    return super.close();
  }

  FutureOr<void> prepareOrder(PrepareEvent event, Emitter<TrackState> emit) {
    emit(PrepareState());
  }

  FutureOr<void> readyOrder(ReadyEvent event, Emitter<TrackState> emit) {
    emit(ReadyState());
  }

  FutureOr<void> checkOrderStatus(
      CheckOrderStatusEvent event, Emitter<TrackState> emit) async {
        await Future.delayed(const Duration(seconds: 3));
    final status = await supabase
        .from('orders')
        .select('status')
        .eq('user_id', supabase.auth.currentUser!.id);

    log('${status[0]['status']}');

    if (status[0]['status'] == 'complete') {
      emit(CheckOrderStatusState());
      log('status is complete');
      add(ReadyEvent());
    }
  }
}
