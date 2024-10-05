
import 'package:bloc/bloc.dart';
import 'package:customer_app/data_layer/product_layer.dart';
import 'package:customer_app/models/product_model.dart';
import 'package:customer_app/services/setup.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final locator = productLocator.get<ProductLayer>();
  List<ProductModel> productSearchList = [];
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<SearchEvent>((event, emit) {
      if (event.searchValue.isEmpty) {
        emit(HomeInitial());
        return;
      }
      emit(LoadingState());

      for (var element in locator.menu) {
        if (element.name?.toLowerCase() == event.searchValue.toLowerCase()) {
          productSearchList.add(element);
        }
      }
      if (productSearchList.isEmpty) {
        emit(SearchResultNotFoundState());
      } else {
        emit(SearchSuccessFoundState());
      }
    });
  }
}
