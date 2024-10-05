import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:moyasar/moyasar.dart';

import '../../reusable_components/animated_snackbar.dart';
import '../payment_confirm_screen.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(double amount) : super(PaymentInitial()) {
    initialLoad(amount);
  }

  int totalPrice = 999;
  PaymentConfig? paymentConfig;

  void initialLoad(double amount) {
    emitLoading();
    totalPrice = (amount * 100).toInt();

    paymentConfig = PaymentConfig(
      publishableApiKey: dotenv.env['Moyasar_API']!,
      amount: totalPrice,
      description: 'Coffee Order',
      creditCard: CreditCardConfig(saveCard: false, manual: false),
    );

    emitUpdate();
  }

  void navigateToPaymentConfirmation(BuildContext context) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const PaymentConfirmScreen()));

  void onPaymentResult(BuildContext context, result) {
    if (result is PaymentResponse) {
      switch (result.status) {
        case PaymentStatus.paid:
          navigateToPaymentConfirmation(context);
        case PaymentStatus.failed:
          showSnackBar(context, 'Payment failed!', AnimatedSnackBarType.error);
        case PaymentStatus.initiated:
          showSnackBar(context, 'Payment initiated. Please confirm.',
              AnimatedSnackBarType.info);
        case PaymentStatus.authorized:
          showSnackBar(context, 'Payment authorized. Awaiting capture.',
              AnimatedSnackBarType.info);
        case PaymentStatus.captured:
          showSnackBar(context, 'Payment captured successfully!',
              AnimatedSnackBarType.info);
      }
    }
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
