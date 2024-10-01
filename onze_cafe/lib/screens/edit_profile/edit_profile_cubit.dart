import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(Profile? profile) : super(EditProfileInitial()) {
    loadInitialValues(profile);
  }

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? avatar;

  loadInitialValues(Profile? profile) {
    nameController.text = profile?.name ?? '';
    emailController.text = profile?.email ?? '';
    phoneController.text = profile?.phone ?? '';
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) avatar = File(img.path);
    emit(UpdateUIState());
  }
}
