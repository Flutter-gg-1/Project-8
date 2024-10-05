part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class UpdateUIState extends CheckoutState {}

final class LoadingState extends CheckoutState {}
