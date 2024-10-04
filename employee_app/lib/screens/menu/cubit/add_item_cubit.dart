import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:employee_app/DB/super_main.dart';
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
  File? imgfiel;
  AddItemCubit() : super(AddItemInitial());

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
        await SuperMain().addItemDb(
            name: namecontroller.text,
            cal: calcontroller.text,
            price: double.parse(pricecontroller.text),
            time: int.parse(timecontroller.text),
            type: typecontroller.text,
            des: deccontroller.text,
            img: imgfiel);

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
