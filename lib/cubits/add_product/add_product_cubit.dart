import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:onze_coffee_app/data/repositories/product_repository.dart';
import 'package:onze_coffee_app/models/product_model.dart';
import 'package:onze_coffee_app/models/variants_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  //?--- TextEditingController
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController caloriesController = TextEditingController();

  //?--- local variables
  final tempretures = ["hot", "cold"];
  int index = 0;
  int categoryId = 1;
  List<File> files = [];
  String productCategory = "black";

  //?--- cubit function
  AddProductCubit() : super(AddProductInitial());
  addProduct() async {
    if (!isClosed) emit(LoadingAddState());
    try {
      //?-- product variant
      VariantsModel variant = VariantsModel(
          size: "small",
          price: double.tryParse(priceController.text) ?? 0,
          calories: int.tryParse(caloriesController.text) ?? 0);
      //?-- product
      ProductModel product = ProductModel(
          productId: 0,
          productName: productNameController.text,
          description: productDescriptionController.text,
          tempreture: tempretures[index],
          variants: [variant],
          productCategory: productCategory,
          imageUrls: files);
      //?-- create product
      await ProductRepository().createProduct(
          product: product, categoryId: categoryId, images: files);
      emit(SuccessState());
    } catch (e) {
      return false;
    }
  }

  updateTempreture() {
    if (!isClosed) emit(UpdateChip());
  }
}