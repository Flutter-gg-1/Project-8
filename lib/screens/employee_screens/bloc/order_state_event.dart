part of 'order_state_bloc.dart';

@immutable
sealed class OrderStateEvent {}


final class StartTimerEvent extends OrderStateEvent {}
final class RunTimerEvent extends OrderStateEvent {}
final class StopTimerEvent extends OrderStateEvent {}

final class GetOrdersItemEvent extends OrderStateEvent {
  final int orderID;
  GetOrdersItemEvent({required this.orderID});
}

final class GetOrdersEvent extends OrderStateEvent {}


