part of 'order_history_cubit.dart';

@immutable
sealed class OrderShowState {}

final class OrderHistoryInitial extends OrderShowState {}

final class LoadingState extends OrderShowState {}

final class SuccessState extends OrderShowState {}

final class ErrorState extends OrderShowState {
  final String msg;

  ErrorState({required this.msg});
}

final class OrderHistoryShowDataState extends OrderShowState {}

class TimerRunInProgress extends OrderShowState {
  final int tickCount;

  TimerRunInProgress({required this.tickCount});
}
