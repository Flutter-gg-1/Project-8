import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  int quantity = 1;
  int statusIndex = 2;
  OrderBloc() : super(OrderInitial()) {
    on<OrderEvent>((event, emit) {});
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
}
