import 'package:flutter/cupertino.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_card_view.dart';
import 'package:onze_cafe/screens/profile/subviews/profile_list_item_view.dart';

import '../profile_cubit.dart';

class AnimatedProfileList extends StatelessWidget {
  const AnimatedProfileList({super.key, required this.cubit});

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    final items = [
      ProfileCardView(),
      ProfileListItemView(
        icon: CupertinoIcons.gear_solid,
        title: 'Edit Profile',
        callback: () => (),
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
      ProfileListItemView(
        icon: CupertinoIcons.phone_fill,
        title: 'Contact Us',
        callback: () => (),
      ),
      ProfileListItemView(
        icon: CupertinoIcons.power,
        title: 'Logout',
        callback: () => cubit.signOut(context),
        isLogout: true,
      ),
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
