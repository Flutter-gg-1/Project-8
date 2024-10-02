import 'package:flutter/material.dart';

class ProfileMostOrderWidget extends StatelessWidget {
  const ProfileMostOrderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 95,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xffA8483D),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Image.asset("assets/image/coffee cup-amico 1.png"),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Hot Coffee\n10 Menu",
            style:  TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16),
          )
        ],
      ),
    );
  }
}
