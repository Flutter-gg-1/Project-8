part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}
final class LoadingState extends OrderState {}
final class UpdateUIState extends OrderState {}
