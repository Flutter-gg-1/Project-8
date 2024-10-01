import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/services/db_operations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'track_event.dart';
part 'track_state.dart';

class TrackBloc extends Bloc<TrackEvent, TrackState> {
  late final RealtimeChannel channel;
  TrackBloc() : super(TrackInitial()) {
    on<ReceivedEvent>(receiveOrder);
    on<PrepareEvent>(prepareOrder);
    on<ReadyEvent>(readyOrder);

    _initializeChannel();
  }

 void _initializeChannel() {
  log('Initializing channel for order updates...');
  
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

  FutureOr<void> receiveOrder(ReceivedEvent event, Emitter<TrackState> emit) {
    emit(ReceivedState());
    Timer(const Duration(seconds: 3), () {
      add(PrepareEvent());
    });
  }

  FutureOr<void> prepareOrder(PrepareEvent event, Emitter<TrackState> emit) {
    emit(PrepareState());
  }

  FutureOr<void> readyOrder(ReadyEvent event, Emitter<TrackState> emit) {
    emit(ReadyState());
  }
}
