import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

class PrimaryBtnView extends StatelessWidget {
  const PrimaryBtnView(
      {super.key, required this.title, required this.callback});
  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: C.primary(brightness),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      onPressed: callback,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title).styled(size: 16, color: Colors.white),
      ),
    );
  }
}
