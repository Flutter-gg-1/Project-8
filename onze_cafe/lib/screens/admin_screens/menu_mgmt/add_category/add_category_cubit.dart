import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onze_cafe/model/menu_category.dart';

import '../../../../reusable_components/animated_snackbar.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit(MenuCategory? category) : super(AddCategoryInitial()) {
    loadInitialValues(category);
  }

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  File? imgFile;
  int sortPriority = 1;

  loadInitialValues(MenuCategory? category) async {
    emitLoading();
    nameController.text = category?.name ?? '';
    descriptionController.text = category?.description ?? '';
    sortPriority = category?.sortPriority ?? 1;

    await Future.delayed(Duration(milliseconds: 50));
    emitUpdate();
  }

  void updateSortPriority(int newValue) {
    sortPriority = newValue;
    emitUpdate();
  }

  void getImage() async {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) imgFile = File(img.path);
    emitUpdate();
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
