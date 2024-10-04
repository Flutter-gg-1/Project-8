import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? hint;
  final String? selectedValue;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final double? width;

  const CustomDropdown({
    super.key,
    required this.label,
    this.hint,
    this.selectedValue,
    required this.items,
    this.onChanged,
    this.validator,
    this.width,
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
              color: Color(0xff3D6B7D),
            ),
          ),
        ),
        context.addSpacer(multiply: 0.01),
        SizedBox(
          width: width,
          child: DropdownButtonFormField<String>(
            value: selectedValue,
            validator: validator,
            decoration: InputDecoration(
              hintStyle: const TextStyle(color: Colors.grey),
              hintText: '   $hint',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff3D6B7D), width: 2.0),
                borderRadius: BorderRadius.circular(18),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff3D6B7D), width: 2.0),
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
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}