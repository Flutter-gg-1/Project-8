import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/enums/coffee_strength.dart';
import 'package:onze_cafe/model/enums/cup_size.dart';
import 'package:onze_cafe/model/enums/milk_options.dart';

import '../../model/menu_item.dart';
import '../../model/offer.dart';
import '../../reusable_components/animated_snackbar.dart';

part 'item_details_state.dart';

class ItemDetailsCubit extends Cubit<ItemDetailsState> {
  ItemDetailsCubit(MenuItem item, List<Offer> offers)
      : super(ItemDetailsInitial()) {
    initialLoad(item, offers);
  }
  MenuItem? item;
  double? offerPrice;
  List<Offer> offers = [];
  CupSize selectedSize = CupSize.medium;
  CoffeeStrength selectedStrength = CoffeeStrength.light;
  int quantity = 1;
  int milkSlider = 0;
  final milkOptions = MilkOption.values.toList();

  initialLoad(MenuItem item, List<Offer> offers) {
    this.item = item;
    this.offers = offers;

    var offer =
        offers.where((offer) => offer.menuItemId == item.id).firstOrNull;
    if (offer != null) {
      offerPrice = offer.price;
    }
    emit(UpdateUIState());
  }

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
