import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_menu_item/add_menu_item_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_menu_item/network_functions.dart';

import '../../../../extensions/color_ext.dart';
import '../../../../model/menu_item.dart';
import '../../../../reusable_components/buttons/circle_btn.dart';
import '../../../../reusable_components/custom_text_field.dart';
import '../../../../utils/validations.dart';

class AddMenuItemScreen extends StatelessWidget {
  const AddMenuItemScreen({super.key, this.item, required this.categories});
  final MenuItem? item;
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMenuItemCubit(item, categories),
      child: Builder(builder: (context) {
        final cubit = context.read<AddMenuItemCubit>();
        final brightness = Theme.of(context).brightness;
        return BlocListener<AddMenuItemCubit, AddMenuItemState>(
          listener: (context, state) {
            if (state is LoadingState) {}
            if (state is UpdateUIState) {}
          },
          child: Scaffold(
            backgroundColor: C.bg1(brightness),
            appBar: AppBar(
              backgroundColor: C.bg1(brightness),
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(CupertinoIcons.chevron_left_square_fill),
                iconSize: 40,
                color: C.primary(brightness),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  width: context.screenWidth * 0.4,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: C.primary(brightness),
                                          width: 2)),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: BlocBuilder<AddMenuItemCubit,
                                          AddMenuItemState>(
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: cubit.getImage,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: cubit.imgFile != null
                                                  ? Image.file(cubit.imgFile!,
                                                      fit: BoxFit.contain)
                                                  : item?.imgUrl == null
                                                      ? const Icon(
                                                          CupertinoIcons
                                                              .photo_on_rectangle,
                                                          size: 40)
                                                      : Image.network(
                                                          item!.imgUrl!,
                                                          fit: BoxFit.contain),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 2,
                                shadowColor:
                                    C.secondary(brightness).withOpacity(0.7),
                                color: C.bg2(brightness),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text('Category').styled()),
                                      BlocBuilder<AddMenuItemCubit,
                                          AddMenuItemState>(
                                        builder: (context, state) {
                                          return cubit.selectedCategory == null
                                              ? Text('You must add at least 1 category!')
                                                  .styled(
                                                      color: C.secondary(
                                                          brightness),
                                                      weight: FontWeight.bold,
                                                      size: 18)
                                              : DropdownButton<String>(
                                                  value: cubit.selectedCategory
                                                          ?.name ??
                                                      '',
                                                  items: List.generate(
                                                    categories.length,
                                                    (index) {
                                                      String value =
                                                          categories[index]
                                                              .name;
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value)
                                                            .styled(),
                                                      );
                                                    },
                                                  ),
                                                  onChanged:
                                                      (String? newValue) {
                                                    if (newValue != null) {
                                                      final selectedCategory =
                                                          categories
                                                              .where((category) =>
                                                                  category
                                                                      .name ==
                                                                  newValue)
                                                              .firstOrNull;

                                                      // Update the cubit with the selected category
                                                      if (selectedCategory !=
                                                          null) {
                                                        cubit.updatedSelectedCat(
                                                            selectedCategory);
                                                      }
                                                    }
                                                  },
                                                );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomTextField(
                                hintText: 'Name',
                                controller: cubit.nameController,
                                validation: Validations.none,
                              ),
                              CustomTextField(
                                hintText: 'Price',
                                controller: cubit.priceController,
                                validation: Validations.validateDouble,
                              ),
                              CustomTextField(
                                hintText: 'Calories',
                                controller: cubit.caloriesController,
                                validation: Validations.validateInt,
                              ),
                              CustomTextField(
                                hintText: 'Ounces',
                                controller: cubit.ozController,
                                validation: Validations.validateDouble,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AddMenuItemCubit, AddMenuItemState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => cubit.upsertMenuItem(context),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomPaint(
                                    size: Size(0,
                                        90), // Specify the size for your custom painting
                                    painter: CircleBtn()),
                              ),
                            ],
                          ),
                          Text(item == null ? 'Create Item' : 'Update Item')
                              .styled(
                                  size: 16,
                                  color: C.bg1(brightness),
                                  weight: FontWeight.bold)
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
