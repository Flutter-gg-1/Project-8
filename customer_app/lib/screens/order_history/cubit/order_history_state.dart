part of 'order_history_cubit.dart';

@immutable
sealed class OrderShowState {}

final class OrderHistoryInitial extends OrderShowState {}

final class OrderHistoryShowDataState extends OrderShowState {}
