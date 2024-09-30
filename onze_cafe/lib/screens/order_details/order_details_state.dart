part of 'order_details_cubit.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}
final class UpdateOrderDetailsState extends OrderDetailsState {}
final class SuccessOrderDetailsState extends OrderDetailsState {}
final class ErrorOrderDetailsState extends OrderDetailsState {}
