import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onze_cafe/supabase/client/supabase_mgr.dart';

import '../../model/profile.dart';
import '../../reusable_components/animated_snackbar.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(Profile? profile) : super(EditProfileInitial()) {
    loadInitialValues(profile);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? avatar;
  bool isAnonymous = true;

  loadInitialValues(Profile? profile) async {
    nameController.text = profile?.name ?? '';
    emailController.text = profile?.email ?? '';
    phoneController.text = profile?.phone ?? '';

    isAnonymous =
        SupabaseMgr.shared.currentUser?.appMetadata['provider'] == 'anon';

    await Future.delayed(Duration(milliseconds: 50));
    emit(UpdateUIState());
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) avatar = File(img.path);
    emit(UpdateUIState());
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }
}
