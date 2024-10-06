import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:employee_app/DB/super_main.dart';
import 'package:employee_app/data_layer/product_layer.dart';
import 'package:employee_app/services/setup.dart';
import 'package:meta/meta.dart';

part 'show_menu_state.dart';

class ShowMenuCubit extends Cubit<ShowMenuState> {
  ShowMenuCubit() : super(ShowMenuInitial());

  delIthem({required String productId}) async {
    try {
      emit(LodingState());
      await SuperMain().delItem(productId: productId);

      emit(DelIthemState());
    } catch (er) {
      log("$er");
    }
  }

  showMenu() async {
    try {
      emit(LodingState());
      final locator = productLocator.get<ProductLayer>();

      locator.menu.clear();
      await SuperMain().getMenu();

      emit(ShowAllMenuState());
    } catch (er) {
      log("$er");
    }
  }
}
