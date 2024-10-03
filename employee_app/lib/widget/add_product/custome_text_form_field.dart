import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormFelid extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final double? width;
  final double horizontal;
  final Widget? suffixIcon;
  final bool readOnly;
  const CustomTextFormFelid({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType,
    this.prefixIcon,
    this.width,
    required this.horizontal,
    this.suffixIcon,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xff3D6B7D)),
          ),
        ),
        context.addSpacer(multiply: 0.01),
        SizedBox(
          width: width,
          child: TextFormField(
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: validator,
            readOnly: readOnly,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: '   $hint',
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff3D6B7D), width: 2.0),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color(0xff3D6B7D), width: 2.0),
                borderRadius: BorderRadius.circular(18),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.orange, width: 2.0),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        )
      ],
    );
  }
}