import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:employee_app/DB/super_main.dart';
import 'package:employee_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController calcontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController typecontroller = TextEditingController();
  TextEditingController deccontroller = TextEditingController();
  TextEditingController imgcontroller = TextEditingController();

  String? productId;
  File? imgfiel;

  bool isEdit = false;
  AddItemCubit() : super(AddItemInitial());

  intiTex({ProductModel? productModel}) {
    log("in intit");
    if (productModel != null) {
      isEdit = true;
      productId = productModel.productId;
      namecontroller.text = productModel.name!;
      calcontroller.text = productModel.cal.toString();
      pricecontroller.text = productModel.price.toString();
      timecontroller.text = productModel.preparationTime.toString();
      typecontroller.text = productModel.type!;
      deccontroller.text = productModel.des!;
    } else {
      isEdit = false;
    }
  }

  addImg() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      imgfiel = File(image.path);

      imgcontroller.text = image.name;
    }
  }

  addItem() async {
    try {
      emit(LodingState());
      if (formKey.currentState!.validate()) {
        if (isEdit == false) {
          await SuperMain().addItemDb(
              name: namecontroller.text,
              cal: calcontroller.text,
              price: double.parse(pricecontroller.text),
              time: int.parse(timecontroller.text),
              type: typecontroller.text,
              des: deccontroller.text,
              img: imgfiel);
        } else {
          await SuperMain().updateItemDb(
              id: productId!,
              name: namecontroller.text,
              cal: calcontroller.text,
              price: double.parse(pricecontroller.text),
              time: int.parse(timecontroller.text),
              type: typecontroller.text,
              des: deccontroller.text,
              img: imgfiel);
        }

        emit(DoneState());
      } else {
        emit(ErorrState(msg: "comate all the Text"));
      }
    } catch (er) {
      log("$er");
      emit(ErorrState(msg: "there was eorr"));
    }
  }
}
