import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/profile/network_functions.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_card_view.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_list_item_view.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';

import '../profile_cubit.dart';

class AnimatedProfileList extends StatelessWidget {
  const AnimatedProfileList({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    final items = [
      ProfileCardView(cubit: cubit),
      if (SupabaseMgr.shared.currentProfile != null)
        Column(children: [
          ProfileListItemView(
            icon: CupertinoIcons.gear_solid,
            title: 'Edit Profile',
            callback: () => cubit.navigateToEditProfile(context),
          ),
          ProfileListItemView(
            icon: CupertinoIcons.bell_fill,
            title: 'Notifications',
            callback: () => (),
          ),
          ProfileListItemView(
            icon: CupertinoIcons.creditcard_fill,
            title: 'Payment',
            callback: () => (),
          ),
        ]),
      ProfileListItemView(
        icon: CupertinoIcons.phone_fill,
        title: 'Contact Us',
        callback: () => (),
      ),
      if (SupabaseMgr.shared.currentProfile != null)
        ProfileListItemView(
          icon: CupertinoIcons.power,
          title: 'Logout',
          callback: () => LogOutAlert.showLogoutConfirmation(
            context, () => cubit.signOut(context),
          ),
          isLogout: true,
        )
      else
        ProfileListItemView(
          icon: CupertinoIcons.profile_circled,
          title: 'Sign In',
          callback: () => cubit.signOut(context),
          isLogout: false,
        )
    ];

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: 1),
          duration: Duration(
              milliseconds: 500 + index * 150), // Stagger the animations
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.translate(
                offset: Offset(0, 50 * (1 - value)), // Slide up animation
                child: child,
              ),
            );
          },
          child: items[index],
        );
      },
    );
  }
}

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
