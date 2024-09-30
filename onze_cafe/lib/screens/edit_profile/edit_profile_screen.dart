import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../extensions/color_ext.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Scaffold(
      backgroundColor: C.bg1(brightness),
      appBar: AppBar(
        backgroundColor: C.bg1(brightness),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(CupertinoIcons.chevron_left_square_fill),
          iconSize: 40,
          color: C.primary(brightness),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(),
        ),
      ),
    );
  }
}
