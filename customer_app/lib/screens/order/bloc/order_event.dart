part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class AddEvent extends OrderEvent {}

class MinusEvent extends OrderEvent {}



class StartTimerEvent extends OrderEvent {}

class TrackStatusChangeEvent extends OrderEvent {}