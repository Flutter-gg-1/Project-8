import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.size,
  }) : super(key: key);

  final String label;
  final String initialValue;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: size.width * 0.04,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff141415).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            initialValue: initialValue,
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.045,
            ),
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}