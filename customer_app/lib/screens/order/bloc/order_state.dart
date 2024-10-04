part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class LoadingState extends OrderState {}

final class SuccessState extends OrderState {}

final class ErrorState extends OrderState {
  final String msg;

  ErrorState({required this.msg});
}

final class ChangeQuantityState extends OrderState {}

class TimerRunInProgress extends OrderState {
  final int tickCount;

  TimerRunInProgress({required this.tickCount});
}
