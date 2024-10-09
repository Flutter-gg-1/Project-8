import 'package:flutter/material.dart';

class ProfileImg extends StatelessWidget {
  const ProfileImg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDCAA70), width: 2),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          "assets/image/Ellipse 478.png",
          height: 85,
          width: 85,
          fit: BoxFit.contain,
        ),
      ),
    ));
  }
}
