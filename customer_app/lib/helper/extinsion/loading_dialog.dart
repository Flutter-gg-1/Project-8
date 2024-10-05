import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

extension LoadingDialog on BuildContext {
  showLoadingDialog() => showDialog(
        barrierDismissible: false,
        context: this,
        builder: (context) => Center(
          child: Lottie.network(
              'https://lottie.host/974f8698-fc20-4586-9636-1276a155e3fb/opaLH3arqC.json',
              fit: BoxFit.fill,
              width: 200,
              height: 200),
        ),
      );
}
