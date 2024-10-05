import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cafe/data_layer/data_layer.dart';
import 'package:onze_cafe/models/item_model.dart';
import 'package:onze_cafe/services/setup.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoadingState()) {
    on<LoadProductsEvent>(loadProducts);
    on<UpdateCartCountEvent>(updateCartCount);
  }

  FutureOr<void> loadProducts(
      LoadProductsEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadingState());
      final products =
          await locator.get<DataLayer>().getItemsByType(event.itemType);
      emit(HomeLoadedState(products));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  FutureOr<void> updateCartCount(
      UpdateCartCountEvent event, Emitter<HomeState> emit) {
    emit(UpdateCartCountState(count: event.count));
    add(LoadProductsEvent(event.itemType));
  }
}
