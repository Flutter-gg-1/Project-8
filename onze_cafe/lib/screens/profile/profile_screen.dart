import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/screens/profile/profile_cubit.dart';
import 'package:onze_cafe/screens/profile/subviews/animated_img_view.dart';
import 'package:onze_cafe/screens/profile/subviews/animated_profile_list.dart';

import '../../extensions/color_ext.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>();
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
                    alignment: Alignment.bottomLeft, child: AnimatedImgView()),
                AnimatedProfileList(cubit: cubit)
              ],
            ),
          )),
        );
      }),
    );
  }
}
