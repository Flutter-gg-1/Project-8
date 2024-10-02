import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key, required this.icons, required this.labelTex, required this.labelVal,
  });

  final IconData icons;
  final String labelTex;
  final String labelVal;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, bottom: 15),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
                color: Color(0xffD9D9D9), shape: BoxShape.circle),
            child:  Icon(
              icons,
              color: const Color(0xffA8483D),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
           Column(
            children: [
              Text(labelTex,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                labelVal,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
