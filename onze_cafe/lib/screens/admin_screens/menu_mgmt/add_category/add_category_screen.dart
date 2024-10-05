import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cafe/extensions/screen_size.dart';
import 'package:onze_cafe/extensions/string_ex.dart';
import 'package:onze_cafe/model/menu_category.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_category/add_category_cubit.dart';
import 'package:onze_cafe/screens/admin_screens/menu_mgmt/add_category/network_functions.dart';

import '../../../../extensions/color_ext.dart';
import '../../../../reusable_components/buttons/circle_btn.dart';
import '../../../../reusable_components/custom_text_field.dart';
import '../../../../utils/validations.dart';

class AddCategoryScreen extends StatelessWidget {
  const AddCategoryScreen({super.key, this.category});
  final MenuCategory? category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCategoryCubit(category),
      child: Builder(builder: (context) {
        final cubit = context.read<AddCategoryCubit>();
        final brightness = Theme.of(context).brightness;
        return BlocListener<AddCategoryCubit, AddCategoryState>(
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
                                      child: BlocBuilder<AddCategoryCubit,
                                          AddCategoryState>(
                                        builder: (context, state) {
                                          return InkWell(
                                            onTap: cubit.getImage,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: cubit.imgFile != null
                                                  ? Image.file(cubit.imgFile!,
                                                      fit: BoxFit.contain)
                                                  : category?.imgUrl == null
                                                      ? const Icon(
                                                          CupertinoIcons
                                                              .photo_on_rectangle,
                                                          size: 40)
                                                      : Image.network(
                                                          category!.imgUrl!,
                                                          fit: BoxFit.contain),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              CustomTextField(
                                hintText: 'Name',
                                controller: cubit.nameController,
                                validation: Validations.name,
                              ),
                              CustomTextField(
                                hintText: 'Description',
                                controller: cubit.descriptionController,
                                validation: Validations.none,
                              ),
                              Card(
                                elevation: 2,
                                shadowColor:
                                    C.secondary(brightness).withOpacity(0.7),
                                color: C.bg1(brightness),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Text('Sort Priority').styled()),
                                      BlocBuilder<AddCategoryCubit,
                                          AddCategoryState>(
                                        builder: (context, state) {
                                          return DropdownButton<int>(
                                            value: cubit.sortPriority,
                                            items: List.generate(10, (index) {
                                              int value = index + 1;
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(value.toString()).styled(),
                                              );
                                            }),
                                            onChanged: (int? newValue) {
                                              if (newValue != null) {
                                                cubit.updateSortPriority(
                                                    newValue);
                                              }
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<AddCategoryCubit, AddCategoryState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () => cubit.upsertCategory(context),
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
                          Text(category == null
                                  ? 'Create Category'
                                  : 'Update Category')
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
