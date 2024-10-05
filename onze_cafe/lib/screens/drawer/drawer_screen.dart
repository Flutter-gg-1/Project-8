import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/screens/drawer/drawer_cubit.dart';

import '../../extensions/color_ext.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => DrawerCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<DrawerCubit>();
        return Drawer(
          backgroundColor: C.bg1(brightness),
          width: context.screenWidth * 0.6,
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 40),
                    child: BlocBuilder<DrawerCubit, DrawerState>(
                      builder: (context, state) {
                        if (state is DrawerInitial) cubit.fetchProfile();
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        blurStyle: BlurStyle.outer)
                                  ],
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: ClipOval(
                                      child: cubit.profile?.avatarUrl == null
                                          ? Image(
                                              image: Img.logo4,
                                              fit: BoxFit.cover)
                                          : Image.network(
                                              cubit.profile!.avatarUrl!,
                                              fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                            Text(cubit.profile?.name ?? '')
                                .styled(weight: FontWeight.bold),
                            Text(cubit.profile?.email ?? '').styled(size: 12),
                          ],
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.person_circle_fill,
                        size: 24, color: C.primary(brightness)),
                    title: Text('Profile').styled(
                        size: 16,
                        weight: FontWeight.bold,
                        color: C.primary(brightness)),
                    onTap: () => cubit.navigateToProfile(context),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.star_fill,
                        size: 24, color: C.primary(brightness)),
                    title: Text('Orders').styled(
                        size: 16,
                        weight: FontWeight.bold,
                        color: C.primary(brightness)),
                    onTap: () => cubit.navigateToOrders(context),
                  ),
                  BlocBuilder<DrawerCubit, DrawerState>(
                    builder: (context, state) {
                      return Column(
                        children: [
                          SwitchListTile(
                            title: Text('English').styled(
                                size: 16,
                                weight: FontWeight.bold,
                                color: C.primary(brightness)),
                            activeColor: C.primary(brightness),
                            inactiveThumbColor: C.secondary(brightness),
                            trackOutlineColor:
                                WidgetStateProperty.all(C.primary(brightness)),
                            value: cubit.isEnglish,
                            onChanged: (bool value) => cubit.toggleIsEnglish(),
                            secondary: Icon(Icons.language,
                                size: 24, color: C.primary(brightness)),
                          ),
                          SwitchListTile(
                            title: Text('Dark').styled(
                                size: 16,
                                weight: FontWeight.bold,
                                color: C.primary(brightness)),
                            activeColor: C.primary(brightness),
                            inactiveThumbColor: C.secondary(brightness),
                            trackOutlineColor:
                                WidgetStateProperty.all(C.primary(brightness)),
                            value: cubit.isDarkMode,
                            onChanged: (bool value) => cubit.toggleIsDarkMode(),
                            secondary: Icon(Icons.dark_mode,
                                size: 24, color: C.primary(brightness)),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image(image: Img.illustration14)),
              )
            ],
          ),
        );
      }),
    );
  }
}
