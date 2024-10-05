import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

import '../extensions/color_ext.dart';

AnimatedSnackBar animatedSnakbar({
  required String msg,
  required AnimatedSnackBarType type,
}) {
  return AnimatedSnackBar(
    animationDuration: Duration(milliseconds: 100),
    builder: ((context) {
      if (context.mounted) {
        final brightness = Theme.of(context).brightness;

        return MaterialAnimatedSnackBar(
          messageText: msg,
          messageTextStyle: TextStyle(
              fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16, color: C.bg1(brightness)),
          type: type,
          foregroundColor: (type == AnimatedSnackBarType.info)
              ? C.primary(brightness)
              : C.bg1(brightness),
          backgroundColor: (type == AnimatedSnackBarType.info)
              ? C.bg1(brightness)
              : (type == AnimatedSnackBarType.success)
                  ? C.primary(brightness)
                  : C.secondary(brightness),
          iconData: (type == AnimatedSnackBarType.info)
              ? CupertinoIcons.info_circle_fill
              : (type == AnimatedSnackBarType.success)
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.xmark_circle_fill,
        );
      } else {
        return const Text('');
      }
    }),
  );
}
