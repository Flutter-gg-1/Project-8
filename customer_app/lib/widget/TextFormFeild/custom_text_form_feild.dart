import 'package:customer_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  const CustomTextFormFeild({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType, this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: context.getWidth(multiply: 0.1)),
      child: Column(
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: validator,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
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
          )
        ],
      ),
    );
  }
}
