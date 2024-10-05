import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/screens/payment/payment_screen.dart';

import '../../reusable_components/animated_snackbar.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit(double amount) : super(CheckoutInitial()) {
    initialLoad(amount);
  }

  double totalPrice = 999;
  bool isPickup = true;

  final textController = TextEditingController();

  void initialLoad(double amount) {
    totalPrice = amount;
    loadCheckout();
  }

  void navigateToPayment(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PaymentScreen(totalPrice: totalPrice.toDouble())));

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

  void loadCheckout() {
    emit(SelectState());
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
