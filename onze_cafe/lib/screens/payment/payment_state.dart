part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class UpdateUIState extends PaymentState {}

final class LoadingState extends PaymentState {}
