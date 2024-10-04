import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/model/menu_item.dart';

import '../../../../model/offer.dart';
import '../../../../reusable_components/animated_snackbar.dart';

part 'add_offer_state.dart';

class AddOfferCubit extends Cubit<AddOfferState> {
  AddOfferCubit(Offer? offer, List<MenuItem> items) : super(AddOfferInitial()) {
    loadInitialValues(offer, items);
  }
  MenuItem? selectedMenuItem;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 7));

  var priceController = TextEditingController();

  loadInitialValues(Offer? offer, List<MenuItem> items) async {
    emitLoading();
    priceController.text = '${offer?.price ?? ''}';
    selectedMenuItem = items.first;
    if (offer != null) {
      startDate = DateTime.parse(offer.startDate);
      endDate = DateTime.parse(offer.endDate);
    }

    emitUpdate();
  }

  void showSnackBar(
      BuildContext context, String msg, AnimatedSnackBarType type) {
    if (context.mounted) {
      animatedSnakbar(msg: msg, type: type).show(context);
    }
  }

  void updatedSelectedItem(MenuItem newValue) {
    selectedMenuItem = newValue;
    emitUpdate();
  }

  void updateStartDate(DateTime newDate) {
    startDate = newDate;
    emitUpdate();
  }

  void updateEndDate(DateTime newDate) {
    endDate = newDate;
    emitUpdate();
  }

  emitLoading() => emit(LoadingState());
  emitUpdate() => emit(UpdateUIState());
}
