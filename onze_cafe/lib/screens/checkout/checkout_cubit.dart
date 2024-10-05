import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/screens/payment_confirm_screen.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial()) {
    loadCheckout();
  }
    final textController = TextEditingController();


  void navigateToConfirmPayment(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PaymentConfirmScreen()));

  void loadCheckout() {
    emit(SelectState());
  }

  void togglePickup(bool isSelected) {
    if (state is SelectState) {
      final currentState = state as SelectState;
      emit(currentState.copyWith(
        isPickupSelected: isSelected,
        isDeliverSelected: !isSelected ? currentState.isDeliverSelected : false,
      ));
    }
  }

  void toggleDeliver(bool isSelected) {
    if (state is SelectState) {
      final currentState = state as SelectState;
      emit(currentState.copyWith(
        isDeliverSelected: isSelected,
        isPickupSelected: !isSelected ? currentState.isPickupSelected : false,
      ));
    }
  }

  void updateClassNumber(String classNumber) {
    if (state is SelectState) {
      final currentState = state as SelectState;
      emit(currentState.copyWith(classNumber: classNumber));
    }
  }
}
