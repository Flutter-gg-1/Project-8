import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/color_ext.dart';
import 'package:onze_cafe/extensions/img_ext.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/edit_profile/edit_profile_cubit.dart';
import 'package:onze_cafe/screens/order_details/order_details_screen.dart';
import 'package:onze_cafe/reusable_components/animation/animated_img_view.dart';
import 'package:onze_cafe/utils/validations.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => EditProfileCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<EditProfileCubit>();
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {},
                    child: Text("Save").styled(
                        color: C.primary(brightness),
                        size: 20,
                        weight: FontWeight.w700)),
              )
            ],
          ),
          body: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: Stack(
                children: [
                  Column(
                    children: [
                      CustomTextField(
                          hintText: 'Full Name',
                          controller: cubit.nameController,
                          validation: Validations.name),
                      CustomTextField(
                          hintText: 'Email',
                          controller: cubit.emailController,
                          validation: Validations.email),
                      CustomTextField(
                          hintText: 'Phone Number',
                          controller: cubit.phoneController,
                          validation: Validations.phoneNumber),
                    ],
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: AnimatedImgView(
                          img: Img.illustration7,
                        ),
                      )),
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
