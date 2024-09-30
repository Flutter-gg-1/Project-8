import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:customer_app/DB/super_main.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  int quantity = 1;
  int statusIndex = 2;
  Timer? _timer;
  int _tickCount = 0;
  final db = SuperMain().superbase;

  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
    on<StartTimerEvent>(_onStartTimer);
    on<TrackStatusChangeEvent>(_onTick);
    on<StatusEvent>((event, emit) {
      statusIndex = event.index;
      emit(ChangeStatusState());
    });
    on<AddEvent>((event, emit) {
      quantity++;
      emit(ChangeQuantityState());
    });
    on<MinusEvent>((event, emit) {
      if (quantity > 1) {
        quantity--;
        emit(ChangeQuantityState());
      }
    });
  }

  void _onStartTimer(StartTimerEvent event, Emitter<OrderState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      add(TrackStatusChangeEvent());
    });
  }

  void _onTick(TrackStatusChangeEvent event, Emitter<OrderState> emit) async {
    var status = await db
        .from('orders')
        .select('status')
        .eq('order_id', '062a8cfc-deb9-4cd6-9c00-e7af246cfce3');
    if (status[0]['status'] == 'Pending') {
      statusIndex = 0;
    }
    if (status[0]['status'] == 'Preparing') {
      statusIndex = 1;
    }
    if (status[0]['status'] == 'Ready') {
      statusIndex = 2;
    }
    if (status[0]['status'] == 'Cancelled') {
      statusIndex = 3;
    }
    _tickCount++;
    log('${statusIndex}');
    log('${status[0]}');

    emit(TimerRunInProgress(tickCount: _tickCount));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
