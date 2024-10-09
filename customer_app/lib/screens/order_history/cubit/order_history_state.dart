part of 'order_history_cubit.dart';

@immutable
sealed class OrderShowState {}

final class OrderHistoryInitial extends OrderShowState {}

final class OrderHistoryShowDataState extends OrderShowState {}

final class SussesState extends OrderShowState {}

final class LoadingState extends OrderShowState {}

final class ErrorState extends OrderShowState {
  final String msg;

  ErrorState({required this.msg});
}
