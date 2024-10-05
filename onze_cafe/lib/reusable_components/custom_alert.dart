import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Image(
          image: Img.loading4,
          fit: BoxFit.fitHeight,
        ));
  }
}
