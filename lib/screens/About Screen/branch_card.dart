import 'package:flutter/material.dart';

class BranchCard extends StatelessWidget {
  final String image;
  const BranchCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff87B1C5)),
      child: Image.asset(image),
    );
  }
}
