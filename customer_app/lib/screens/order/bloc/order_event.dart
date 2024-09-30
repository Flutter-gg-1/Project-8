part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class AddEvent extends OrderEvent {}

class MinusEvent extends OrderEvent {}

class StatusEvent extends OrderEvent {
  final int index;

  StatusEvent({required this.index});
}

class StartTimerEvent extends OrderEvent {}

class TrackStatusChangeEvent extends OrderEvent {}