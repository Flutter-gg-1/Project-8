import 'dart:developer';

import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/models/product_model.dart';
import 'package:employee_app/screens/menu/add_cubit/add_item_cubit.dart';
import 'package:employee_app/widget/add_product/custom_dropdown_widget.dart';
import 'package:employee_app/widget/add_product/custome_text_form_field.dart';
import 'package:employee_app/widget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key, this.productModel});

  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemCubit()..intiTex(productModel: productModel),
      child: Builder(builder: (context) {
        final cubit = context.read<AddItemCubit>();

       

        return Form(
          key: cubit.formKey,
          child: BlocListener<AddItemCubit, AddItemState>(
            listener: (context, state) {
              if (state is DoneState) {
                Navigator.pop(context);
                Navigator.pop(context, true);

                log("very good");
              }

              if (state is LodingState) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        )));
              }
              if (state is ErorrState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    state.msg,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                ));
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/image/logo_small.png'),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.getWidth(multiply: 0.08)),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: context.getHeight(multiply: 0.05),
                          ),
                          Image.asset('assets/image/add_menu_logo.png'),
                          context.addSpacer(multiply: 0.05),
                          CustomTextFormFelid(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the product name';
                              }
                              return null;
                            },
                            controller: cubit.namecontroller,
                            label: 'Name Product',
                            keyboardType: TextInputType.text,
                            hint: 'latte',
                            horizontal: 0,
                            readOnly: false,
                          ),
                          context.addSpacer(multiply: 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormFelid(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the calories';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Calories must be a valid number';
                                  }
                                  return null;
                                },
                                readOnly: false,
                                controller: cubit.calcontroller,
                                label: 'Cal',
                                keyboardType: TextInputType.number,
                                hint: '210',
                                width: context.getWidth(multiply: 0.395),
                                horizontal: 0,
                                suffixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                      Icons.local_fire_department_outlined,
                                      color: Color(0xff3D6B7D)),
                                ),
                              ),
                              SizedBox(
                                width: context.getWidth(multiply: 0.05),
                              ),
                              CustomTextFormFelid(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the price';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Price must be a valid number';
                                  }
                                  return null;
                                },
                                readOnly: false,
                                controller: cubit.pricecontroller,
                                label: 'Price',
                                keyboardType: TextInputType.number,
                                hint: '12',
                                width: context.getWidth(multiply: 0.395),
                                horizontal: 0,
                                suffixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(Icons.price_change_outlined,
                                      color: Color(0xff3D6B7D)),
                                ),
                              ),
                            ],
                          ),
                          context.addSpacer(multiply: 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextFormFelid(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the preparation time';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Preparation time must be a valid integer';
                                  }
                                  return null;
                                },
                                readOnly: false,
                                controller: cubit.timecontroller,
                                label: 'Prepare Time',
                                keyboardType: TextInputType.number,
                                hint: '6',
                                width: context.getWidth(multiply: 0.395),
                                horizontal: 0,
                                suffixIcon: const Align(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: Icon(
                                    Icons.access_time_rounded,
                                    color: Color(0xff3D6B7D),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.getWidth(multiply: 0.05),
                              ),
                              CustomDropdown(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Chose  type';
                                  }
                                  return null;
                                },
                                items: ["Classic_Coffee"],
                                onChanged: (p0) {
                                  cubit.typecontroller.text = p0 ?? "";
                                },
                                label: 'Type',
                                hint: 'latte',
                                width: context.getWidth(multiply: 0.395),
                              ),
                            ],
                          ),
                          context.addSpacer(multiply: 0.02),
                          CustomTextFormFelid(
                            readOnly: false,
                            controller: cubit.deccontroller,
                            label: 'Description',
                            keyboardType: TextInputType.text,
                            hint: 'write your dec here',
                            horizontal: 0,
                          ),
                          context.addSpacer(multiply: 0.02),
                          CustomTextFormFelid(
                            readOnly: true,
                            controller: cubit.imgcontroller,
                            label: 'Image',
                            keyboardType: TextInputType.text,
                            hint: 'image.png',
                            horizontal: 0,
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                              child: IconButton(
                                onPressed: () async {
                                  cubit.addImg();
                                },
                                icon: const Icon(Icons.image),
                              ),
                            ),
                          ),
                          context.addSpacer(multiply: 0.02),
                          CustomButton(
                            icon: Icons.add_shopping_cart_outlined,
                            title: "add",
                            onPressed: () {
                              cubit.addItem();
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
