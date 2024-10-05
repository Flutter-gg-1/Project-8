part of 'checkout_cubit.dart';

@immutable
sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

final class SelectState extends CheckoutState {
  final bool isPickupSelected;
  final bool isDeliverSelected;
  final String classNumber;

  SelectState({
    this.isPickupSelected = false,
    this.isDeliverSelected = false,
    this.classNumber = '',
  });
  SelectState copyWith({
    bool? isPickupSelected,
    bool? isDeliverSelected,
    String? classNumber,
  }) {
    return SelectState(
      isPickupSelected: isPickupSelected ?? this.isPickupSelected,
      isDeliverSelected: isDeliverSelected ?? this.isDeliverSelected,
      classNumber: classNumber ?? this.classNumber,
    );
  }
}
