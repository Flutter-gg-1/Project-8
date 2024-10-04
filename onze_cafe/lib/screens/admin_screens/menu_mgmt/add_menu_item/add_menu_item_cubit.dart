import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/model/menu_item.dart';

import '../../../../reusable_components/animated_snackbar.dart';

part 'add_menu_item_state.dart';

class AddMenuItemCubit extends Cubit<AddMenuItemState> {
  AddMenuItemCubit(MenuItem? item, List<MenuCategory> categories)
      : super(AddMenuItemInitial()) {
    loadInitialValues(item, categories);
  }

  var nameController = TextEditingController();
  var caloriesController = TextEditingController();
  var priceController = TextEditingController();
  var ozController = TextEditingController();
  MenuCategory? selectedCategory;
  File? imgFile;
  var menuItem =
      MenuItem(categoryId: '', name: '', calories: 0, price: 0, oz: 0);

  loadInitialValues(MenuItem? item, List<MenuCategory> categories) async {
    emitLoading();
    nameController.text = item?.name ?? '';
    caloriesController.text = item?.calories.toString() ?? '';
    priceController.text = item?.price.toString() ?? '';
    ozController.text = item?.oz.toString() ?? '';
    selectedCategory = categories.first;
    menuItem.imgUrl = item?.imgUrl;

    await Future.delayed(Duration(milliseconds: 50));
    emitUpdate();
  }

  updateMenuItem() {
    try {
      final int calories = int.parse(caloriesController.text);
      final double price = double.parse(priceController.text);
      final double oz = double.parse(ozController.text);

      menuItem.categoryId = selectedCategory?.id ?? '';
      menuItem.name = nameController.text;
      menuItem.calories = calories;
      menuItem.price = price;
      menuItem.oz = oz;
    } catch (_) {
      rethrow;
    }
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

  void updatedSelectedCat(MenuCategory newValue) {
    selectedCategory = newValue;
    emitUpdate();
  }

  void emitLoading() => emit(LoadingState());
  void emitUpdate() => emit(UpdateUIState());
}
