part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class ChangeQuantityState extends OrderState {}

final class ChangeStatusState extends OrderState {}