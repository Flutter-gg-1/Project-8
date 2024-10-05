part of 'order_list_cubit.dart';

@immutable
sealed class OrderListState {}

final class OrderListInitial extends OrderListState {}

final class OrderShowState extends OrderListState {}

final class ErorrState extends OrderListState {
  final String msg;

  ErorrState({required this.msg});
}

final class LoadingState extends OrderListState {}

final class NoLodingState extends OrderListState {}

class TimerRunInProgress extends OrderListState {
  final int tickCount;

  TimerRunInProgress({required this.tickCount});
}
