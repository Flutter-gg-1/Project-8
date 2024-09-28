import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

import '../../../extensions/color_ext.dart';

class ProfileListItemView extends StatelessWidget {
  const ProfileListItemView(
      {super.key,
      required this.icon,
      required this.title,
      required this.callback,
      this.isLogout = false});
  final IconData icon;
  final String title;
  final VoidCallback callback;
  final bool isLogout;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: callback,
        child: Card(
          elevation: 4,
          shadowColor: C.secondary(brightness),
          color: C.bg1(brightness),
          child: ListTile(
              leading: Icon(icon,
                  color: isLogout
                      ? C.secondary(brightness)
                      : C.primary(brightness)),
              title: Text(title).styled(weight: FontWeight.bold),
              trailing: Icon(CupertinoIcons.chevron_right,
                  size: 16,
                  color: isLogout
                      ? C.secondary(brightness)
                      : C.primary(brightness))),
        ),
      ),
    );
  }
}
