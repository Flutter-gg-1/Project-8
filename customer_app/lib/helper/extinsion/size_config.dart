import 'package:flutter/material.dart';

extension SizeConfig on BuildContext {
  getWidth({required double multiply}) =>
      MediaQuery.of(this).size.width * multiply;
  getHeight({required double multiply}) =>
      MediaQuery.of(this).size.height * multiply;
  addSpacer({double? multiply}) => SizedBox(
      height: multiply == null
          ? MediaQuery.of(this).size.height * 0.06
          : MediaQuery.of(this).size.height * multiply);

  double getSize({
    double? comperedNumber = 500,
    required double smallDivider,
    required double largeDivider,
    required BuildContext context,
  }) {
    return context.getWidth(multiply: 1) > comperedNumber!
        ? context.getWidth(multiply: largeDivider)
        : context.getWidth(multiply: smallDivider);
        
  }
}
