import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/enums/coffee_strength.dart';
import 'package:onze_cafe/model/enums/cup_size.dart';
import 'package:onze_cafe/model/enums/milk_options.dart';

import '../../reusable_components/animated_snackbar.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit() : super(ItemDetailsInitial());
  CupSize selectedSize = CupSize.medium;
  CoffeeStrength selectedStrength = CoffeeStrength.light;
  int quantity = 1;
  int milkSlider = 0;
  final milkOptions = MilkOption.values.toList();

  void navigateBack(BuildContext context) => Navigator.of(context).pop();

  void selectSize(CupSize cupSize) {
    selectedSize = cupSize;
    emit(UpdateUIState());
  }

  void selectStrength(CoffeeStrength strength) {
    selectedStrength = strength;
    emit(UpdateUIState());
  }

  void incrementCount() {
    quantity++;
    emit(UpdateUIState());
  }

  void decrementCount() {
    if (quantity > 1) {
      quantity--;
      emit(UpdateUIState());
    }
  }

  void updateSliderValue(int value) {
    milkSlider = value;
    emit(UpdateUIState());
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }
}
