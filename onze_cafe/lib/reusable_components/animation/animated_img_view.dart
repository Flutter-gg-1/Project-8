import 'package:flutter/material.dart';

import '../../extensions/img_ext.dart';

class AnimatedImgView extends StatelessWidget {
  const AnimatedImgView({super.key, required this.img});
  final ImageProvider img;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Offset>(
      tween: Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)),
      duration: Duration(seconds: 1), // Set the duration of the slide
      curve: Curves.easeInOut, // Add some easing for smooth animation
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset * MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Image(
              image: img,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
