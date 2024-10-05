
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';

class LogOutAlert {
  static void showLogoutConfirmation(BuildContext context, Function onLogout) {
    final brightness = Theme.of(context).brightness;
    Future<void> showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: C.bg2(brightness),
            title:
                const Text('Logout').styled(weight: FontWeight.bold, size: 20),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Are you sure you want to log out?').styled(),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel').styled(weight: FontWeight.bold),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child:
                    const Text('Logout').styled(color: C.secondary(brightness)),
                onPressed: () {
                  onLogout();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    showMyDialog();
  }
}
