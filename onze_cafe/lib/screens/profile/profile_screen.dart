import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_card_view.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_list_item_view.dart';

import '../../extensions/color_ext.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Image(image: Img.illustration4, fit: BoxFit.contain)),
            ListView(
              children: [
                ProfileCardView(),
                ProfileListItemView(
                    icon: CupertinoIcons.gear_solid,
                    title: 'Edit Profile',
                    callback: () => ()),
                ProfileListItemView(
                    icon: CupertinoIcons.bell_fill,
                    title: 'Notifications',
                    callback: () => ()),
                ProfileListItemView(
                    icon: CupertinoIcons.creditcard_fill,
                    title: 'Payment',
                    callback: () => ()),
                ProfileListItemView(
                    icon: CupertinoIcons.phone_fill,
                    title: 'Contact Us',
                    callback: () => ()),
                ProfileListItemView(
                  icon: CupertinoIcons.power,
                  title: 'Logout',
                  callback: () => (),
                  isLogout: true,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
