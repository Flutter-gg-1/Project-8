import 'package:flutter/material.dart';

import '../extensions/color_ext.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.max = 1,
    required this.controller,
    required this.validation,
    this.onChanged,
    this.readOnly = false,
  });
  final String hintText;
  final Widget? prefixIcon;
  final int? max;
  final Widget? suffixIcon;
  final TextEditingController controller;
  final Function(String value) validation;
  final bool readOnly;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        style: TextStyle(color: C.text(brightness),fontFamily: 'Poppins',),
        readOnly: readOnly,
        maxLines: max,
        // obscureText: ,
        onChanged: onChanged,
        minLines: 1,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            prefixIcon: prefixIcon,
            prefixIconColor: C.primary(brightness),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                  color: C.primary(brightness).withOpacity(0.8), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: C.accent(brightness), width: 2),
            ),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: C.accent(brightness), width: 2)),
            filled: true,
            fillColor: C.secondary(brightness).withOpacity(0.0),
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: 'Poppins',
              color: C.primary(brightness),
            )),
        validator: (value) => validation(value ?? ''),
      ),
    );
  }
}
