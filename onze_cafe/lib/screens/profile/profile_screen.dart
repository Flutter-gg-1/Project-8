import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/managers/alert_mgr.dart';
import 'package:onze_cafe/reusable_components/buttons/custom_back_btn.dart';
import 'package:onze_cafe/screens/profile/profile_cubit.dart';
import 'package:onze_cafe/reusable_components/animation/animated_img_view.dart';
import 'package:onze_cafe/screens/profile/subviews/animated_profile_list.dart';

import '../../extensions/color_ext.dart';
import '../../extensions/img_ext.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => ProfileCubit(context),
      child: Builder(builder: (context) {
        final cubit = context.read<ProfileCubit>();
        return BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LoadingState) {
              AlertManager().showAlert(context: context);
            } else if (state is UpdateUIState) {
              AlertManager().dismissPreviousAlert(context);
            }
          
          },
          child: Scaffold(
            backgroundColor: C.bg1(brightness),
            appBar: AppBar(
              backgroundColor: C.bg1(brightness),
              leading: CustomeBackBtn(brightness: brightness),
            ),
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(32),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: AnimatedImgView(
                        img: Image(
                          image: Img.illustration4,
                          fit: BoxFit.contain,
                        ),
                      )),
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return AnimatedProfileList(cubit: cubit);
                    },
                  )
                ],
              ),
            )),
          ),
        );
      }),
    );
  }
}
