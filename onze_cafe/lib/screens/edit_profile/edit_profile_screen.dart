import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/reusable_components/buttons/circle_btn.dart';
import 'package:onze_cafe/reusable_components/custom_text_field.dart';
import 'package:onze_cafe/screens/edit_profile/edit_profile_cubit.dart';
import 'package:onze_cafe/screens/edit_profile/network_functions.dart';

import '../../extensions/color_ext.dart';
import '../../extensions/img_ext.dart';
import '../../model/profile.dart';
import '../../reusable_components/animation/animated_img_view.dart';
import '../../utils/validations.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key, this.profile});
  final Profile? profile;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return BlocProvider(
      create: (context) => EditProfileCubit(profile),
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
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ListView(
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Container(
                                width: context.screenWidth * 0.4,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: C.primary(brightness),
                                        width: 2)),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: BlocBuilder<EditProfileCubit,
                                        EditProfileState>(
                                      builder: (context, state) {
                                        return InkWell(
                                          onTap: cubit.getImage,
                                          child: ClipOval(
                                            child: cubit.avatar != null
                                                ? Image.file(cubit.avatar!,
                                                    fit: BoxFit.cover)
                                                : profile?.avatarUrl == null
                                                    ? const Icon(
                                                        CupertinoIcons
                                                            .photo_on_rectangle,
                                                        size: 40)
                                                    : Image.network(
                                                        profile!.avatarUrl!,
                                                        fit: BoxFit.cover),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            CustomTextField(
                              hintText: 'Name',
                              controller: cubit.nameController,
                              validation: Validations.name,
                            ),
                            CustomTextField(
                              hintText: 'Email',
                              controller: cubit.emailController,
                              validation: Validations.email,
                              readOnly: true,
                            ),
                            CustomTextField(
                              hintText: 'Phone',
                              controller: cubit.phoneController,
                              validation: Validations.phoneNumber,
                            ),
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 3,
                        child: AnimatedImgView(
                          img: Img.illustration7,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: cubit.isAnonymous
                        ? () => ()
                        : () => cubit.updateProfile(context),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomPaint(
                                  size: Size(0,
                                      90), // Specify the size for your custom painting
                                  painter: CircleBtn()),
                            ),
                          ],
                        ),
                        Text(cubit.isAnonymous
                                ? 'Create Account'
                                : 'Update Profile')
                            .styled(
                                size: 16,
                                color: C.bg1(brightness),
                                weight: FontWeight.bold)
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
