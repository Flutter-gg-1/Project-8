import 'package:flutter/material.dart';
import 'package:onze_cafe/reusable_components/custom_alert.dart';

class AlertManager {
  static final AlertManager _instance = AlertManager._internal();
  bool _isAlertVisible = false;

  factory AlertManager() {
    return _instance;
  }

  AlertManager._internal();

  void showAlert({
    required BuildContext context,
  }) {
    dismissPreviousAlert(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    ).then((_) {
      _isAlertVisible = false;
    });

    _isAlertVisible = true;
  }

  void dismiss(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
    _isAlertVisible = false;
  }

  void dismissPreviousAlert(BuildContext context) {
    if (_isAlertVisible) {
      dismiss(context);
    }
  }
}
