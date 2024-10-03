import 'package:employee_app/helper/extinsion/size_config.dart';
import 'package:employee_app/screens/profile/profile_screen.dart';
import 'package:employee_app/widget/add_product/custome_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController calcontroller = TextEditingController();
    TextEditingController pricecontroller = TextEditingController();
    TextEditingController timecontroller = TextEditingController();
    TextEditingController typecontroller = TextEditingController();
    TextEditingController deccontroller = TextEditingController();
    TextEditingController imgcontroller = TextEditingController();
    return Scaffold(
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
                    controller: namecontroller,
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
                        readOnly: false,
                        controller: calcontroller,
                        label: 'Cal',
                        keyboardType: TextInputType.number,
                        hint: '210',
                        width: context.getWidth(multiply: 0.395),
                        horizontal: 0,
                        suffixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(Icons.local_fire_department_outlined,
                              color: Color(0xff3D6B7D)),
                        ),
                      ),
                      SizedBox(
                        width: context.getWidth(multiply: 0.05),
                      ),
                      CustomTextFormFelid(
                        readOnly: false,
                        controller: pricecontroller,
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
                        readOnly: false,
                        controller: timecontroller,
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
                      CustomTextFormFelid(
                        readOnly: false,
                        controller: typecontroller,
                        label: 'Type',
                        keyboardType: TextInputType.text,
                        hint: 'latte',
                        width: context.getWidth(multiply: 0.395),
                        horizontal: 0,
                        suffixIcon: const Align(
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: Icon(
                            Icons.type_specimen_outlined,
                            color: Color(0xff3D6B7D),
                          ),
                        ),
                      ),
                    ],
                  ),
                  context.addSpacer(multiply: 0.02),
                  CustomTextFormFelid(
                    readOnly: false,
                    controller: deccontroller,
                    label: 'Description',
                    keyboardType: TextInputType.text,
                    hint: 'write your dec here',
                    horizontal: 0,
                  ),
                  context.addSpacer(multiply: 0.02),
                  CustomTextFormFelid(
                    readOnly: true,
                    controller: imgcontroller,
                    label: 'Image',
                    keyboardType: TextInputType.text,
                    hint: 'image.png',
                    horizontal: 0,
                    suffixIcon: Align(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.image),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
